#
# Cookbook:: logstash
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
# This will install Logstash

include_recipe "java::default"

yum_repository 'Adding logstash Key' do
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :create
end

cookbook_file 'File copy' do
  path '/etc/yum.repos.d/logstash.repo'
  source 'logstash.repo'
end

execute 'Cleaning Packages' do
  command 'yum clean all'
  action :run
end

yum_package 'logstash' do
  flush_cache before: true
  action :install
end

template 'Adding Logstash Conf File' do
  path '/etc/logstash/conf.d/02-beats-input.conf'
  source '02-beats-input.conf.erb'
end

template 'Adding Logstash Conf File' do
  path '/etc/logstash/conf.d/10-syslog-filter.conf'
  source '10-syslog-filter.conf.erb'
end

template 'Adding Logstash Conf File' do
  path '/etc/logstash/conf.d/30-elasticsearch-output.conf'
  source '30-elasticsearch-output.conf.erb'
  variables(
       :elasticsearchip => "#{node['logstash']['elasticsearchip']}" 
   )
end

service 'logstash' do
  action [:enable, :start] 
end

