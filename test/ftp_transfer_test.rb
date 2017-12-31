require 'test_helper'

class FtpTransferTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FtpTransfer::VERSION
  end
end
