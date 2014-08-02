#
# centos config
#


remote_file "#{Chef::Config[:file_cache_path]}/syslinux-6.02.tar.gz" do
  source 'https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-6.02.tar.gz'
  owner "root"
  group "root"
  mode "0644"
  
  action :create_if_missing
  
end

script "pull out portions of syslinux" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "/var/lib/tftpboot/menu.c32"
  code <<-EOH
    STATUS=0
    tar -zxvf syslinux-6.02.tar.gz --strip-components 3 -C /var/lib/tftpboot syslinux-6.02/bios/core/pxelinux.0 || STATUS=1
    tar -zxvf syslinux-6.02.tar.gz --strip-components 4 -C /var/lib/tftpboot syslinux-6.02/bios/com32/menu/menu.c32 || STATUS=1
    exit $STATUS
    EOH
end

remote_file "#{Chef::Config[:file_cache_path]}/ipxe-bin.tar.gz" do
  source 'https://github.com/csc/ipxe/releases/download/v1.0.1619-h/ipxe-bin.tar.gz'
  owner "root"
  group "root"
  mode "0644"
  
  action :create_if_missing
  
end

script "pull out portions of ipxe" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  creates "/var/lib/tftpboot/ipxe.iso"
  code <<-EOH
    STATUS=0
    tar -zxvf ipxe-bin.tar.gz  -C /var/lib/tftpboot ipxe.iso || STATUS=1
    tar -zxvf ipxe-bin.tar.gz  -C /var/lib/tftpboot ipxe.lkrn || STATUS=1
    tar -zxvf ipxe-bin.tar.gz  -C /var/lib/tftpboot undionly.kpxe || STATUS=1
    exit $STATUS
    EOH
end


directory "/var/lib/tftpboot/pxelinux.cfg" do
  owner "root"
  group "root"
  mode "0755"
  
  action :create
end


template "/var/lib/tftpboot/pxelinux.cfg/default" do
  source "default.erb"
  owner "root"
  group "root"
  mode "0644"
end


