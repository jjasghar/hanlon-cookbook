#
# Cookbook Name:: hanlon
# Recipe:: hanlon
#
# Copyright (C) 2014
#
#
#

if node['hanlon']['debug-image'] != 'false'
  remote_file '/tmp/hnl_mk_debug-image.1.0.iso' do
    source node['hanlon']['debug-image-source']
    owner 'root'
    group 'root'
    mode '0644'
    action :create_if_missing
  end
end

if node['hanlon']['dev-image'] != 'false'
  remote_file '/tmp/hnl_mk_dev-image.1.0.iso' do
    source node['hanlon']['dev-image-source']
    owner 'root'
    group 'root'
    mode '0644'
    action :create_if_missing
  end
end

if node['hanlon']['prod-image'] != 'false'
  remote_file '/tmp/hnl_mk_prod-image.1.0.iso' do
    source node['hanlon']['prod-image-source']
    owner 'root'
    group 'root'
    mode '0644'
    action :create_if_missing
  end
end

directory node['hanlon']['dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

case node['platform_family']
when 'debian'

  remote_file "#{Chef::Config[:file_cache_path]}/hanlon_#{node['hanlon']['version']}_amd64.deb" do
    source "#{node['hanlon']['deb-pkg-source']}"
    action :create_if_missing
  end

  dpkg_package 'hanlon' do
    source "#{Chef::Config[:file_cache_path]}/hanlon_#{node['hanlon']['version']}_amd64.deb"
    version node['hanlon']['version']
    action :install
  end

  %w(curl git).each do |pkg|
    package pkg do
      action [:install]
    end
  end

when 'rhel'

  remote_file "#{Chef::Config[:file_cache_path]}/hanlon_#{node['hanlon']['version']}_x86_64.rpm" do
    source "#{node['hanlon']['rpm-pkg-source']}"
    action :create_if_missing
  end

  rpm_package 'hanlon' do
    source "#{Chef::Config[:file_cache_path]}/hanlon_#{node['hanlon']['version']}_x86_64.rpm"
    version node['hanlon']['version']
    action :install
  end

  link "/usr/local/bin/ruby" do
    to "/opt/hanlon/embedded/bin/ruby"
  end

  link "/usr/local/bin/gem" do
    to "/opt/hanlon/embedded/bin/gem"
  end

  link "/usr/local/bin/bundle" do
    to "/opt/hanlon/embedded/bin/bundle"
  end

  link "/usr/local/bin/puma" do
    to "/opt/hanlon/embedded/bin/puma"
  end

  link "/usr/local/bin/hanlon" do
    to "/opt/hanlon/embedded/hanlon/cli/hanlon"
  end

  link "/usr/local/bin/hanlon_init" do
    to "/opt/hanlon/embedded/hanlon/hanlon_init"
  end

  %w(libtool openssl zlib-devel curl git).each do |pkg|
    package pkg do
      action [:install]
    end
  end

  execute 'bundle install' do
    cwd '/opt/hanlon/embedded/hanlon'
    command '/usr/local/bin/bundle install'
  end

end

execute 'hanlon_init' do
  cwd '/opt/hanlon/embedded/hanlon'
  command 'hanlon_init'
  not_if { File.exist?('/opt/hanlon/embedded/hanlon/web/config/hanlon_server.conf') }
end

template '/opt/hanlon/embedded/hanlon/web/config/hanlon_server.conf' do
  source 'hanlon_server.conf.erb'
end

include_recipe 'runit'

runit_service 'hanlon'
