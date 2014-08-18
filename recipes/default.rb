#
# Cookbook Name:: hanlon
# Recipe:: default
#
# Copyright (C) 2014
#
#
#

include_recipe 'hanlon::ruby'
include_recipe 'hanlon::dnsmasq'
include_recipe 'hanlon::database'
include_recipe 'hanlon::networking'
include_recipe 'hanlon::ipxe'
include_recipe 'hanlon::hanlon'
