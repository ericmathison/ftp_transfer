require 'net/ftp'
require 'digest/md5'

class FtpTransfer
  def initialize(local_directory = '/home/eric/Desktop/sending-orders', archive_dir = '/home/eric/Desktop/archived-orders')
    @local_directory = File.expand_path(local_directory)
    @archived_orders_directory = File.expand_path(archive_dir)
    @ftp = Net::FTP.new('<host>', '<user>', '<password>')
    @ftp.passive = true
  end

  def upload(remote_directory = 'public_html/new_orders')
    @remote_directory = remote_directory
    # comment out to try a failed file transfer:
    @ftp.chdir(@remote_directory)
    Dir["#{@local_directory}/*.edi"].each do |file|
      begin
        @ftp.putbinaryfile(file)
      rescue
        raise Net::FTPError, 'files did not transfer successfully'
      end
      archive_local_order(file) if transfer_success?(file)
    end
  end

  def download(remote_directory = 'public_html/processed_orders')
  end

  private

  def transfer_success?(file)
    @ftp.size(File.basename(file)) > 0 &&
    Digest::MD5.hexdigest(@ftp.getbinaryfile(File.basename(file), nil)) ==
    Digest::MD5.hexdigest(File.read(file))
  end

  def archive_local_order(file)
    FileUtils.move(file, @archived_orders_directory) if File.exists?(file)
  end
end
