default['dnsmasq']['enable_dns'] = true
default['dnsmasq']['enable_dhcp'] = true

default['hanlon']['dhcp_interface'] = 'eth1'
default['hanlon']['no_dhcp_interface'] = 'eth0'
default['hanlon']['dhcp_end_ip'] = '172.16.0.100'

default['hanlon']['dir'] = '/opt/hanlon'

default['hanlon']['persist_host'] = '127.0.0.1'
default['hanlon']['persist_mode'] = ':mongo'
default['hanlon']['persist_port'] = 27017
default['hanlon']['persist_timeout'] = 10
default['hanlon']['persist_username'] = ''
default['hanlon']['persist_password'] = ''

default['tftp']['directory'] = '/var/lib/tftpboot'
