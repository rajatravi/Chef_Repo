#
# Cookbook:: filebeat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

yum_repository 'Adding Filebeat Key' do
  gpgkey 'https://packages.elastic.co/GPG-KEY-elasticsearch'
  action :create
end

cookbook_file 'copy file' do
  path '/etc/yum.repos.d/filebeat.repo'
  source 'filebeat.repo'
end

execute 'Cleaning Packages' do
  command 'yum clean all'
  action :run
end

yum_package 'filebeat' do
  flush_cache before: true
  action :install
end

template 'Adding Kibana Conf File' do
  path '/etc/filebeat/filebeat.yml'
  source 'filebeat.yml.erb'
  variables(
    :elasticsearch_ip => "#{node['filebeat']['elasticsearch_ip']}",
    :logstash_ip => "#{node['filebeat']['logstash_ip']}"
    )
end

service 'filebeat' do
 action [:enable, :start]
 subscribes :restart, " template'/etc/filebeat/filebeat.yml' ", :immediately
end

