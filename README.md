ftp_transfer
============

Here is an example of an upload. In this case, the optional archive directory has been specified so a copy of the transferred files will be kept locally in that directory.
```ruby
require 'ftp_transfer'
FtpTransfer.new('foobar.bazquux.com',
  'user',
  'password',
  '~/files-to-send',
  '~/archived-files').upload('public_html/file-uploads')
```

Here is an example of a download
```
FtpTransfer.new('foobar.bazquux.com',
  'user',
  'password',
  '~/received-files').download('public_html/files-to-download')
```
