name 'td-agent'
version '4' # git ref

dependency 'jemalloc' unless windows?
dependency 'ruby'
dependency 'nokogiri'
dependency 'postgresql' unless windows?
dependency 'fluentd'

build do
  env = with_standard_compiler_flags(with_embedded_path)
  gem "install --local #{ENV['FLUENTD_STACKDRIVER_SOURCE']}"
  gem "install --local #{ENV['FLUENTD_COMMANDER_SOURCE']}"
end
