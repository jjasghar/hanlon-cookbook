#
# Cookbook Name:: hanlon
# Recipe:: default
#
# Copyright (C) 2014 
#
# 
#

include_recipe "hanlon::ruby"
include_recipe 'hanlon::tftp'
include_recipe "hanlon::hanlon"

