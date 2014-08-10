#
# main hanlon build
#
case node["platform"]
when "debian", "ubuntu"
  package "git-core" do
    action :install
  end
when "redhat", "centos", "fedora"
  package "git" do
    action :install
  end
end


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
