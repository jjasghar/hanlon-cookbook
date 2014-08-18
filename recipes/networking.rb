#
# Cookbook Name:: hanlon
# Recipe:: networking
#
# Copyright (C) 2014
#
#
#

include_recipe 'iptables'

iptables_rule 'hanlon-iptables'

sysctl_param 'net.ipv4.tcp_fin_timeout' do
  value 1
end

include_recipe 'sysctl::apply'
