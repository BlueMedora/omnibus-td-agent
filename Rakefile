require 'rake'
require 'rspec/core/rake_task' 
require 'shellwords' 
require 'bump/tasks' 
task :spec    => ['spec:all', 'bats:all']
task :default => :build

Bump.replace_in_default = ['config/projects/bm-agent.rb']
Bump.tag_by_default = true

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

task :build, [:platform] do |t, args|
  args.with_defaults(platform: 'centos7')
  sh 'docker run -it --rm '\
    '-v $HOME/.ssh:/root/.ssh '\
    '-v $(pwd)/:/code  '\
    "-v $(pwd)/cache/#{args.platform}:/var/cache/omnibus "\
    "-v $(pwd)/cache/bundler/#{args.platform}:/root/.bundler "\
    '-w /code '\
    'ccheek21/omnibus:centos-7.2 '\
    "bash -c 'chmod 600 /root/.ssh/config && rbenv exec bundle install --full-index --binstubs --path /root/.bundler && rbenv exec bundle  exec  omnibus build bm-agent'"
end

task :release do
  version = Bump::Bump.current
  sh "aws s3 cp pkg/bm-agent-#{version}-0.el7.x86_64.rpm s3://bindplane-logs-downloads/agent/centos7/"
end

