default['dnsmasq']['enable_dns'] = true
default['dnsmasq']['enable_dhcp'] = true

default['hanlon']['dhcp_interface'] = 'eth1'
default['hanlon']['no_dhcp_interface'] = 'eth0'
default['hanlon']['dhcp_end_ip'] = '172.16.0.100'

default['hanlon']['version'] = '0.0.0'
default['hanlon']['dir'] = '/opt/hanlon'

default['hanlon']['persist_host'] = '127.0.0.1'
default['hanlon']['persist_mode'] = ':mongo'
default['hanlon']['persist_port'] = 27017
default['hanlon']['persist_timeout'] = 10
default['hanlon']['persist_username'] = ''
default['hanlon']['persist_password'] = ''

default['tftp']['directory'] = '/var/lib/tftpboot'

default['hanlon']['debug-image'] = 'false'
default['hanlon']['debug-image-source'] = 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_debug-image.1.0.iso'
default['hanlon']['dev-image'] = 'false'
default['hanlon']['dev-image-source'] = 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_dev-image.1.0.iso'
default['hanlon']['prod-image'] = 'true'
default['hanlon']['prod-image-source'] = 'https://github.com/csc/Hanlon-Microkernel/releases/download/v1.0/hnl_mk_prod-image.1.0.iso'

default['hanlon']['deb-pkg-source'] = 'https://dl.dropboxusercontent.com/u/15377/hanlon_0.0.0%2B20140821181747-1_amd64.deb'
default['hanlon']['rpm-pkg-source'] = 'https://dl.dropboxusercontent.com/u/15377/hanlon-0.0.0%2B20140821213227-1.x86_64.rpm'
