name 'td-agent'
version '4' # git ref

dependency 'jemalloc' unless windows?
dependency 'ruby'
dependency 'nokogiri'
dependency 'postgresql' unless windows?
dependency 'fluentd'

build do
  env = with_standard_compiler_flags(with_embedded_path)
  gemfile = File.join(Omnibus::Config.project_root, 'InstalledGemfile')
  bundle "install --gemfile=#{gemfile}", :env => { 'GITHUB_TOKEN' => '64783e90a7deaaa24a9fd6763635a485780c6590' }
end
