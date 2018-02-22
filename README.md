# ftp_transfer

Handles tranfering many files at once over FTP using a higher level api than net/ftp from the standard library.

## #upload
```ruby
require 'ftp_transfer'
FtpTransfer.new(
  host: 'foobar.bazquux.com',
  user: 'user',
  pass: 'password',
  local_dir: '~/files-to-send').upload('file-upload-dir')
```

## #download
```ruby
FtpTransfer.new(
  host: 'foobar.bazquux.com',
  user: 'user',
  pass: 'password',
  local_dir: '~/received-files').download('file-download-dir')
```

## Optional Settings (Examples):
```ruby
port: 21212 # defaults to 21
pattern: '*.jpg'
```

Only applies for uploads:
```ruby
archive_dir: '~/archived-files'
```

The pattern option will default to `'*'` when not specified.

Specifying the archive directory option keeps a copy of the transferred files locally in the given directory. There is not currently an archive option for the download method (Pull requests welcome!).
