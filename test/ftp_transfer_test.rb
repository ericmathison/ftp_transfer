require 'test_helper'
require 'fake_ftp'

class FtpTransferTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FtpTransfer::VERSION
  end

  def test_upload
    server = FakeFtp::Server.new(21212, 21213)
    server.start

    FtpTransfer.new(
        host: '127.0.0.1',
        user: 'user',
        pass: 'password',
        port: 21212,
        local_dir: File.expand_path('fixtures', File.dirname(__FILE__))
      ).upload('~')

    assert_includes(server.files, 'file1')
    assert_includes(server.files, 'file2')
    assert_equal(8, server.file('file1').bytes)
    assert_equal(9, server.file('file2').bytes)
  end
end
