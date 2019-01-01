name 'fluentd'
# fluentd v0.14.11
default_version 'master'

dependency 'ruby'
dependency 'bundler'

source git: 'https://github.com/fluent/fluentd.git'
relative_path 'fluentd'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  bundle 'install --full-index --path vendor/bundle'
  rake 'build', env: env
  gem 'install --no-ri --no-rdoc pkg/fluentd-*.gem', env: env
end
