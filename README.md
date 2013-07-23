ftp_transfer
============

Here is an example of an upload. In this case, the optional archive directory option has been specified so a copy of the transferred files will be kept locally in that directory.
```ruby
require 'ftp_transfer'
FtpTransfer.new('foobar.bazquux.com',
  'user',
  'password',
  '~/files-to-send',
  archive_dir: '~/archived-files', pattern: '*.jpg').upload('file-upload-dir')
```

Here is an example of a download
```ruby
FtpTransfer.new('foobar.bazquux.com',
  'user',
  'password',
  '~/received-files',
  pattern: '*.jpg').download('file-download-dir')
```
There is not currently an archive option for the download method. If you need that for your application feel free to send a pull request.
