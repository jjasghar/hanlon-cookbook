#
# main hanlon build
#

remote_file "/tmp/hnl_mk_debug-image.1.0.iso" do
  source "https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_debug-image.1.0.iso"
  owner "root"
  group "root"
  mode "0644"
  
  action :create_if_missing
  
end

remote_file "/tmp/hnl_mk_dev-image.1.0.iso" do
  source "https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_dev-image.1.0.iso"
  owner "root"
  group "root"
  mode "0644"
  
  action :create_if_missing
  
end

remote_file "/tmp/hnl_mk_prod-image.1.0.iso" do
  source "https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_prod-image.1.0.iso"
  owner "root"
  group "root"
  mode "0644"
  
  action :create_if_missing
  
end

directory "/opt/hanlon" do
  owner "root"
  group "root"
  mode "0755"
  
  action :create
end

git "/opt/hanlon/" do
  repository "https://github.com/csc/Hanlon.git"
  reference "master"
  action :sync
end

gem_package 'bundler' do
  gem_binary '/usr/local/bin/gem'
  options '--no-ri --no-rdoc'
end

execute 'bundle install' do
  cwd '/opt/hanlon'
  command '/usr/local/bin/bundle install'
end

execute 'hanlon_init' do
  cwd '/opt/hanlon'
  command '/usr/local/bin/ruby hanlon_init'
  not_if {File.exists?("/opt/hanlon/web/config/hanlon_server.conf")}
end

include_recipe 'runit'

runit_service "hanlon-puma"
