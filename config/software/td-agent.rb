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
  bundle "install --gemfile=#{gemfile}", :env => { 'GITHUB_TOKEN' => ENV['GITHUB_TOKEN'] }
end
