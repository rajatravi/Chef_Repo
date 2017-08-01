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

yum_package 'Installing ' do
  package_name ['epel-release','httpd-tools','nginx']
  action :install
end

template 'Adding nginx conf' do
  path '/etc/nginx/conf.d/kibana.conf'
  source 'default.erb'
  variables(
    :kibana_server_ip => "#{node['kibana']['kibana_server_ip']}"
   )
end

service 'kibana' do
 action [:enable, :start]
 subscribes :restart, " template'/etc/kibana/kibana.yml' ", :immediately
end
