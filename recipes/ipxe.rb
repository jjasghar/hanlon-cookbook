#
# Cookbook Name:: hanlon
# Recipe:: ipxe
#
# Copyright (C) 2014
#
#
#

remote_file "#{Chef::Config[:file_cache_path]}/syslinux-6.02.tar.gz" do
  source 'https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.02.tar.gz'
  owner 'root'
  group 'root'
  mode '0644'

  action :create_if_missing

end

script 'pull out portions of syslinux' do
  interpreter 'bash'
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "#{node['tftp']['directory']}/menu.c32"
  code <<-EOH
    STATUS=0
    tar -zxvf syslinux-6.02.tar.gz --strip-components 3 -C #{node['tftp']['directory']} syslinux-6.02/bios/core/pxelinux.0 || STATUS=1
    tar -zxvf syslinux-6.02.tar.gz --strip-components 4 -C #{node['tftp']['directory']} syslinux-6.02/bios/com32/menu/menu.c32 || STATUS=1
    exit $STATUS
    EOH
end

remote_file "#{Chef::Config[:file_cache_path]}/ipxe-bin.tar.gz" do
  source 'https://github.com/csc/ipxe/releases/download/v1.0.1619-h/ipxe-bin.tar.gz'
  owner 'root'
  group 'root'
  mode '0644'

  action :create_if_missing

end

script 'pull out portions of ipxe' do
  interpreter 'bash'
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "#{node['tftp']['directory']}/ipxe.iso"
  code <<-EOH
    STATUS=0
    tar -zxvf ipxe-bin.tar.gz  -C #{node['tftp']['directory']} ipxe.iso || STATUS=1
    tar -zxvf ipxe-bin.tar.gz  -C #{node['tftp']['directory']} ipxe.lkrn || STATUS=1
    tar -zxvf ipxe-bin.tar.gz  -C #{node['tftp']['directory']} undionly.kpxe || STATUS=1
    exit $STATUS
    EOH
end

directory "#{node['tftp']['directory']}/pxelinux.cfg" do
  owner 'root'
  group 'root'
  mode '0755'

  action :create
end

template "#{node['tftp']['directory']}/pxelinux.cfg/default" do
  source 'default.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
