lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ftp_transfer/version'

Gem::Specification.new do |spec|
  spec.name        = 'ftp_transfer'
  spec.version     = FtpTransfer::VERSION
  spec.summary     = 'Bulk FTP Transfer'
  spec.description = 'A bulk ftp transfer library'
  spec.authors     = ['Eric Mathison']
  spec.email       = 'dev@ekmathison.com'
  spec.files       = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^test/})
  end
  spec.licenses = ['GPL-2.0']
  spec.add_development_dependency 'fake_ftp', '~> 0.3'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_runtime_dependency 'stringglob', '~> 0.0.3'
  spec.homepage    =
    'https://github.com/ericmathison/ftp_transfer'
end
