#
# Cookbook Name:: hanlon
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

case node["platform"]
when "debian", "ubuntu"
  include_recipe 'apt'
  include_recipe 'build-essential::default'

when "redhat", "centos", "fedora"
  include_recipe 'yum'
end

include_recipe 'tftp'

case node["platform"]
when "debian", "ubuntu"
  include_recipe 'hanlon::ubuntu'

  
when "redhat", "centos", "fedora"
  include_recipe 'hanlon::centos'
end


include_recipe "hanlon::hanlon"
