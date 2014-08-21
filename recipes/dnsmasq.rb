#
# Cookbook Name:: hanlon
# Recipe:: dnsmasq
#
# Copyright (C) 2014
#
#
#

dhcp_interface = node['hanlon']['dhcp_interface']
no_dhcp_interface = node['hanlon']['no_dhcp_interface']
dhcp_interface_ip = node['network']['interfaces'][dhcp_interface]['addresses'].keys[1]
dhcp_end_ip = node['hanlon']['dhcp_end_ip']

node.default['dnsmasq']['dns'] = {
  'server' => "#{dhcp_interface_ip}@#{dhcp_interface}"
}

node.default['dnsmasq']['dhcp'] = {
  'interface' => dhcp_interface,
  'no-dhcp-interface' => no_dhcp_interface,
  'domain' => 'hanlon.local',
  'dhcp-match' => 'IPXEBOOT,175',
  'dhcp-boot' => 'net:IPXEBOOT,bootstrap.ipxe',
  'dhcp-boot' => 'undionly.kpxe',
  'enable-tftp' => nil,
  'tftp-root' => node['tftp']['directory'],
  'dhcp-range' => "#{dhcp_interface},#{dhcp_interface_ip},#{dhcp_end_ip},12h",
  'dhcp-option' => "option:ntp-server,#{dhcp_interface_ip}"
}

include_recipe 'dnsmasq'
