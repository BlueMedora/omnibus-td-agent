name 'td-agent'
version '4' # git ref

dependency 'jemalloc' unless windows?
dependency 'ruby'
dependency 'fluentd'
dependency 'fluentd-controller'
