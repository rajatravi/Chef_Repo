#
# Cookbook:: kibana
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved
# This cookbook will install Kibana

execute 'kibana public Key' do
  command 'rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  action :run
end

cookbook_file 'copy file' do
  path '/etc/yum.repos.d/kibana.repo'
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
 action [:enable, :start]
 subscribes :restart, " template'/etc/kibana/kibana.yml' ", :immediately
end
