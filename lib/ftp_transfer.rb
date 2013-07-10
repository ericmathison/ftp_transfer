require 'net/ftp'
require 'digest/md5'

class FtpTransfer
  def initialize(host, user, password, local_directory, archive_dir = nil, options = {})
    @host = host
    @user = user
    @password = password
    @local_directory = File.expand_path(local_directory)
    @archive_directory = archive_dir.nil? ? nil : File.expand_path(archive_dir)
    @pattern = options[:pattern] || '*'
    @ftp = Net::FTP.new(@host, @user, @password)
    @ftp.passive = true
  end

  def upload(remote_directory)
    @remote_directory = remote_directory
    # comment out to try a failed file transfer:
    @ftp.chdir(@remote_directory)
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
