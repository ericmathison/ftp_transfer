ftp_transfer
============

The ftp_transfer gem was designed in an attempt to create a simpler api for bulk ftp transfers.

Here is an example of an upload. In this case, the optional archive directory option has been specified so a copy of the transferred files will be kept locally in that directory. The pattern option is also optional and will default to '*'.
```ruby
require 'ftp_transfer'
FtpTransfer.new(
  host: 'foobar.bazquux.com',
  user: 'user',
  pass: 'password',
  port: 21212, # optional param (will default to 21)
  local_dir: '~/files-to-send',
  pattern: '*.jpg',
  archive_dir: '~/archived-files').upload('file-upload-dir')
```

Here is an example of a download
```ruby
FtpTransfer.new(
  host: 'foobar.bazquux.com',
  user: 'user',
  pass: 'password',
  local_dir: '~/received-files',
  pattern: '*.jpg').download('file-download-dir')
```
There is not currently an archive option for the download method. If you need that for your application, feel free to send a pull request.
