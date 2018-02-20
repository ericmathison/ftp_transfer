Gem::Specification.new do |s|
  s.name        = 'ftp_transfer'
  s.version     = '0.1.0'
  s.summary     = 'Bulk FTP Transfer'
  s.description = 'A bulk ftp transfer library'
  s.authors     = ['Eric Mathison']
  s.email       = 'dev@ekmathison.com'
  s.files       = %w(Gemfile README.md ftp_transfer.gemspec lib/ftp_transfer.rb
                     lib/ftp_transfer/version.rb)
  s.licenses = ['GPL-2']
  s.add_development_dependency 'fake_ftp', '~> 0.3'
  s.add_development_dependency 'minitest', '~> 5.0'
  s.add_runtime_dependency 'stringglob', '~> 0.0.3'
  s.homepage    =
    'http://github.com/ericmathison/ftp_transfer'
end
