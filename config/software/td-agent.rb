name 'td-agent'
version '4' # git ref

dependency 'jemalloc' unless windows?
dependency 'ruby'
dependency 'nokogiri'
dependency 'postgresql' unless windows?
dependency 'fluentd'

build do
  env = with_standard_compiler_flags(with_embedded_path)
  gem "specific_install https://#{ENV['GITHUB_TOKEN']}@github.com/BlueMedora/fluentd-stackdriver-plugin.git"
  gem "specific_install https://#{ENV['GITHUB_TOKEN']}@github.com/BlueMedora/fluentd-controller.git"
end
