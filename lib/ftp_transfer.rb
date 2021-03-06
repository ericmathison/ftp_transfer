require 'ftp_transfer/version'
require 'net/ftp'
require 'digest/md5'
require 'fileutils'
require 'stringglob'

class FtpTransfer
  def initialize(options = {})
    @host = options[:host]
    @user = options[:user]
    @password = options[:pass]
    @local_directory = File.expand_path(options[:local_dir])
    @archive_directory = nil
    if options[:archive_dir]
      @archive_directory = File.expand_path(options[:archive_dir])
    end
    @pattern = options[:pattern] || '*'
    @port = options[:port] || 21
    @ftp = Net::FTP.new
    @ftp.connect(@host, @port)
    @ftp.login(@user, @password)
    @ftp.passive = true
  end

  def upload(remote_directory)
    @ftp.chdir(remote_directory)
    Dir["#{@local_directory}/#{@pattern}"].each do |file|
      begin
        @ftp.putbinaryfile(file)
      rescue
        raise Net::FTPError, 'files did not transfer successfully'
      end
      archive_locally(file) if transfer_success?(file) && archive?
    end
  end

  def download(remote_directory)
    @ftp.chdir(remote_directory)
    Dir.chdir(File.expand_path(@local_directory))
    @ftp.nlst
      .select { |file| StringGlob.regexp(@pattern) =~ file }
      .each do |file|
        begin
          @ftp.getbinaryfile(file)
        rescue
          raise Net::FTPError, 'files did not transfer successfully'
        end
        @ftp.delete(file) if transfer_success?(file)
      end
  end

  private

  def transfer_success?(file)
    @ftp.size(File.basename(file)) > 0 &&
    Digest::MD5.hexdigest(@ftp.getbinaryfile(File.basename(file), nil)) ==
    Digest::MD5.hexdigest(File.read(file))
  end

  def archive_locally(file)
    FileUtils.move(file, @archive_directory) if File.exists?(file) && archive?
  end

  def archive?
    !@archive_directory.nil?
  end
end
