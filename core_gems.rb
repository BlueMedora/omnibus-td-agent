dir 'core_gems'
download "bundler", "1.16.2"
download "msgpack", "1.2.4"
download "cool.io", "1.5.3"
download "http_parser.rb", "0.6.0"
download "yajl-ruby", "1.4.0"
download "sigdump", "0.2.4"
download "oj", "3.3.9"
download "tzinfo", "1.2.5"
download "tzinfo-data", "1.2018.5"
download "dig_rb", "1.0.1"
download 'serverengine', '2.0.7'
if windows?
  download 'ffi', '1.9.25'
  download 'ffi-win32-extensions', '1.0.3'
  download 'win32-ipc', '0.7.0'
  download 'win32-event', '0.6.3'
  download 'win32-service', '0.8.10'
  download 'windows-pr', '1.2.6'
  download 'win32-api', '1.7.1-universal-mingw32'
  download 'windows-api', '0.4.4'
end
