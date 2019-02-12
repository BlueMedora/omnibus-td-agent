require 'erb'
require 'fileutils'
require 'rubygems'

name 'bm-agent'
maintainer 'Blue Medora'
homepage 'http://bindplane.com'
description 'A log collector for BindPlane'

install_dir "/opt/#{name}"

if windows?
  install_dir "#{default_root}/opt/#{name}"
else
  install_dir "#{default_root}/#{name}"
end

build_version   '0.1.1'
build_iteration 0

# creates required build directories

override :ruby, version: '2.4.5'
override :jemalloc, version: '4.5.0'
override :rubygems, version: '2.6.14'
override :fluentd, version: 'f30865f82a0d19730940a52c7cb12de88d1821fb' # v1.2.6

# td-agent dependencies/components
dependency 'td-agent'
dependency 'td-agent-files'
dependency 'td-agent-cleanup'

# version manifest file
dependency 'version-manifest'

case ohai['os']
when 'linux'
  case ohai['platform_family']
  when 'debian'
    runtime_dependency 'lsb-base'
  when 'rhel'
    runtime_dependency 'initscripts'
    runtime_dependency 'rpm-build'
    if ohai['platform_version'][0] == '5'
      runtime_dependency 'redhat-lsb'
    else
      runtime_dependency 'redhat-lsb-core'
    end
  end
end

exclude '\.git*'
exclude 'bundler\/git'

compress :dmg do
end

package :msi do
  upgrade_code '76dcb0b2-81ad-4a07-bf3b-1db567594171'
end
