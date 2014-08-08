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

  script "install ruby" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    creates "/usr/local/bin/ruby"
    code <<-EOH
      STATUS=0
      wget http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p547.tar.gz || STATUS=1
      tar -xvzf ruby-1.9.3-p547.tar.gz  || STATUS=1
      cd ruby-1.9.3-p547/  || STATUS=1
      ./configure --prefix=/usr/local  || STATUS=1
      make  || STATUS=1
      make install  || STATUS=1
      cd /tmp  || STATUS=1
      rm -rf ruby-1.9.3-p547* || STATUS=1
      exit $STATUS
    EOH
  end

when "redhat", "centos", "fedora"
  include_recipe 'yum'
  include_recipe 'build-essential::default'

  %w{libtool openssl zlib-devel}.each do |pkg|
     package pkg do
       action :install
     end
  end

  script "install libyaml" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    creates "maybe"
    code <<-EOH
    STATUS=0
     wget http://pyyaml.org/download/libyaml/yaml-0.1.6.tar.gz || STATUS=1
     tar xzvf yaml-0.1.6.tar.gz || STATUS=1
     cd yaml-0.1.6 || STATUS=1
     ./configure --prefix=/usr/local || STATUS=1
     make || STATUS=1
     make install
     exit $STATUS
    EOH
  end

  script "install ruby" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    creates "/usr/local/bin/ruby"
    code <<-EOH
      STATUS=0
      wget http://cache.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p547.tar.gz || STATUS=1
      tar -xvzf ruby-1.9.3-p547.tar.gz  || STATUS=1
      cd ruby-1.9.3-p547/  || STATUS=1
      ./configure --prefix=/usr/local  || STATUS=1
      make  || STATUS=1
      make install  || STATUS=1
      cd /tmp  || STATUS=1
      rm -rf ruby-1.9.3-p547* || STATUS=1
      exit $STATUS
    EOH
  end
end

include_recipe 'tftp'

case node["platform"]
when "debian", "ubuntu"
  include_recipe 'hanlon::ubuntu'
when "redhat", "centos", "fedora"
  include_recipe 'hanlon::centos'
end

include_recipe "hanlon::hanlon"

execute "install bundler" do
  cwd "/opt/hanlon"
  user "root"
  group "root"
  command "gem install bundler"
  creates "/usr/local/bin/bundler"
  action :run
end

