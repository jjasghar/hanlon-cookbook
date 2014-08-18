#
# Cookbook Name:: hanlon
# Recipe:: database
#
# Copyright (C) 2014
#
#
#

case node['hanlon']['persist_mode']
when ':mongo'
  include_recipe 'mongodb::default'

  mongodb_instance 'mongodb' do
    port node['hanlon']['persist_port']
  end

when ':postgres'
  include_recipe 'postgresql::server'

  pg_user node['hanlon']['persist_username'] do
    privileges superuser: false, createdb: true, login: true
    password node['hanlon']['persist_password']
  end

  pg_database 'project_hanlon' do
    owner node['hanlon']['persist_username']
    encoding 'UTF-8'
    template 'template0'
    locale 'en_US.UTF-8'
  end
end
