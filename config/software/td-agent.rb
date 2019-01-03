name 'td-agent'
version '4' # git ref

dependency 'jemalloc' unless windows?
dependency 'ruby'
dependency 'nokogiri'
dependency 'postgresql' unless windows?
dependency 'fluentd'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  gem "build #{ENV['FLUENTD_COMMANDER_SOURCE']}/fluentd_agent.gemspec"
  gem "install --local #{ENV['FLUENTD_COMMANDER_SOURCE']}/fluentd_agent*.gem"

  gem "build #{ENV['FLUENTD_STACKDRIVER_SOURCE']}/fluentd-stackdriver-plugin.gemspec"
  gem "install --local #{ENV['FLUENTD_STACKDRIVER_SOURCE']}/fluentd-stackdriver-plugin*.gem"
end
