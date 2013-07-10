require 'net/ftp'

class FtpTransfer
  def initialize(local_outgoing_directory = '/home/eric/Desktop/sending-orders', archive_dir = '/home/eric/Desktop/archived-orders')
    @local_outgoing_directory = File.expand_path(local_outgoing_directory)
    @archived_orders_directory = File.expand_path(archive_dir)
  end

  def upload(remote_directory = 'public_html/new_orders')
    Dir["#{@local_outgoing_directory}/*.edi"].each do |file|
      Net::FTP.open('foobar.bazquux.com', 'username-goes-here', 'password-goes-here') do |ftp|
        ftp.passive = true
        ftp.chdir(remote_directory)
        ftp.puttextfile(file)
        ftp.nlst.select { |server_file| server_file =~ /\.edi$/ }
          .each { |server_file| archive_local_order(server_file) if File.exists?("#{@local_outgoing_directory}/#{server_file}") }
      end
    end
  end

  private

  def archive_local_order(order_file)
    FileUtils.move("#{@local_outgoing_directory}/#{order_file}", @archived_orders_directory)
  end
end
