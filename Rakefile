require 'rake'
require 'rspec/core/rake_task'
require 'shellwords'

task :spec    => ['spec:all', 'bats:all']
task :default => :spec

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    targets << File.basename(dir)
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    desc "Run serverspec tests to #{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = target
      t.pattern = "spec/#{target}/*_spec.rb"
    end
  end
end

task :build do
  sh "docker run -it --rm "\
    "-e GITHUB_TOKEN='2b44f9f7bb610d5dac0940577ec73857b10855b4' "\
    "-v $(PWD):/code  "\
    "-v /tmp/omnibus:/var/cache/omnibus "\
    "-v /tmp/bundler:/root/.bundler "\
    "-w /code "\
    "ccheek21/omnibus:centos-7.2 "\
    "bash -c 'bundle install --full-index --binstubs --path /root/.bundler && bundle  exec  omnibus build bm-agent'"
end

task :upload do
  sh "aws s3 cp --acl public-read pkg/bm-agent-1.0.0-0.el7.x86_64.rpm s3://demo-log-installer/agent-dev-latest.rpm"
  print("Upload complete.")
  print("RPM can be downloaded at http://s3.amazonaws.com/demo-log-installer/agent-dev-latest.rpm")
end
