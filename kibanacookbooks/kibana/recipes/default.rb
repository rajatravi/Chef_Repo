#
# Cookbook:: kibana
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved
# This cookbook will install Kibana

yum_repository 'Adding kibana Key' do
  gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :create
end

cookbook_file '/etc/yum.repos.d/kibana.repo' do
  source 'kibana.repo'
end

execute 'Cleaning Packages' do
  command 'yum clean all'
  action :run
end

yum_package 'kibana' do
  flush_cache before: true
  action :install
end

template 'Adding Kibana Conf File' do
  path '/etc/kibana/kibana.yml'
  source 'kibana.yml.erb'
  variables(
    :port => "#{node['kibana']['port']}",
    :host => "#{node['kibana']['host']}"
    )
end

service 'kibana' do
 action :restart
end
