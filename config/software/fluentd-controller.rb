name 'fluentd-controller'

dependency 'ruby'
dependency 'bundler'

version = '0.2.11'
default_version "v#{version}"
source git: 'git@github.com:BlueMedora/fluentd-controller.git'
relative_path 'fluentd-controller'

build do
  env = with_standard_compiler_flags(with_embedded_path)

  bundle 'install'
  rake 'build', env: env
  gem "install --no-ri --no-rdoc pkg/fluentd-controller-#{version}.gem", env: env
end
