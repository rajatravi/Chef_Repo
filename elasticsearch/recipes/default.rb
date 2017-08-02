#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe "java::default"

execute 'Adding elasticsearch public Key' do
  command 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :run
end

cookbook_file 'copy file' do
  path '/etc/yum.repos.d/elasticsearch.repo'
  source 'elasticsearch.repo'
end

execute 'Cleaning Packages' do
  command 'yum clean all'
  action :run
end

yum_package 'elasticsearch' do
  flush_cache before: true
  action :install
end

template 'Adding elasticsearch Conf File' do
  path '/etc/elasticsearch/elasticsearch.yml'
  source 'elasticsearch.yml.erb'
  variables(
    :host => "#{node['elasticsearch']['host']}",
    :port => "#{node['elasticsearch']['port']}"
    )
end

service 'elasticsearch' do
 action [:enable, :start]
 subscribes :restart, " template'/etc/elasticsearch/elasticsearch.yml' ", :immediately
end

