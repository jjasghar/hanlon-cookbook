#
# Cookbook Name:: hanlon
# Recipe:: hanlon
#
# Copyright (C) 2014
#
#
#

remote_file '/tmp/hnl_mk_debug-image.1.0.iso' do
  source 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_debug-image.1.0.iso'
  owner 'root'
  group 'root'
  mode '0644'

  action :create_if_missing

end

remote_file '/tmp/hnl_mk_dev-image.1.0.iso' do
  source 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_dev-image.1.0.iso'
  owner 'root'
  group 'root'
  mode '0644'

  action :create_if_missing

end

remote_file '/tmp/hnl_mk_prod-image.1.0.iso' do
  source 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_prod-image.1.0.iso'
  owner 'root'
  group 'root'
  mode '0644'

  action :create_if_missing

end

directory node['hanlon']['dir'] do
  owner 'root'
  group 'root'
  mode '0755'

  action :create
end

git node['hanlon']['dir'] do
  repository 'https://github.com/csc/Hanlon.git'
  reference 'master'
  action :sync
end

gem_package 'bundler' do
  gem_binary '/usr/local/bin/gem'
  options '--no-ri --no-rdoc'
end

execute 'bundle install' do
  cwd node['hanlon']['dir']
  command '/usr/local/bin/bundle install'
end

execute 'hanlon_init' do
  cwd '/opt/hanlon'
  command '/usr/local/bin/ruby hanlon_init'
  not_if { File.exist?('/opt/hanlon/web/config/hanlon_server.conf') }
end

template "#{node['hanlon']['dir']}/web/config/hanlon_server.conf" do
  source 'hanlon_server.conf.erb'
end

include_recipe 'runit'

runit_service 'hanlon'
