#
# Cookbook Name:: hanlon
# Recipe:: ruby
#
# Copyright (C) 2014
#
#
#

case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'

when 'redhat', 'centos', 'fedora'
  include_recipe 'yum'
  include_recipe 'yum-epel'

  %w{ libtool openssl zlib-devel libyaml-devel }.each do |pkg|
     package pkg do
       action :install
     end
  end
end

include_recipe 'ruby_build'

ruby_build_ruby '1.9.3-p547' do
  prefix_path '/usr/local'
  action :install
end
