Gem::Specification.new do |s|
  s.name        = 'ftp_transfer'
  s.version     = '0.0.1'
  s.date        = '2013-07-10'
  s.summary     = 'Bulk FTP Transfer'
  s.description = 'A bulk ftp transfer library'
  s.authors     = ['Eric Mathison']
  s.email       = 'dev@ekmathison.com'
  s.files       = ['lib/ftp_transfer.rb']
  s.licenses = ['GPL-2']
  s.add_development_dependency 'fake_ftp', '0.0.9'
  s.add_runtime_dependency 'stringglob', '~> 0.0.3'
  s.homepage    =
    'http://github.com/ericmathison/ftp_transfer'
end
