require 'serverspec'
include Serverspec::Helper::Exec

describe file('/usr/local/bin/ruby') do
  it { should be_file }
end

describe command('netstat -ua | grep tftp') do
  it { should return_exit_status 0 }
end

describe file('/var/lib/tftpboot/pxelinux.0') do
  it { should be_file }
end

describe file('/var/lib/tftpboot/menu.c32') do
  it { should be_file }
end

describe file('/var/lib/tftpboot/ipxe.iso') do
  it { should be_file }
end

describe file('/var/lib/tftpboot/ipxe.lkrn') do
  it { should be_file }
end

describe file('/var/lib/tftpboot/undionly.kpxe') do
  it { should be_file }
end

describe file('/var/lib/tftpboot/pxelinux.cfg') do
  it { should be_directory }
end

describe file('/var/lib/tftpboot/pxelinux.cfg/default') do
  it { should be_file }
end

describe file('/tmp/hnl_mk_debug-image.1.0.iso') do
  it { should be_file }
end

describe file('/tmp/hnl_mk_dev-image.1.0.iso') do
  it { should be_file }
end

describe file('/tmp/hnl_mk_prod-image.1.0.iso') do
  it { should be_file }
end

describe file('/opt/hanlon') do
  it { should be_directory }
end

describe file('/opt/hanlon/.git') do
  it { should be_directory }
end

describe file('/usr/local/bin/bundler') do
  it { should be_file }
end



