require 'serverspec'
include Serverspec::Helper::Exec

describe file('/usr/local/bin/ruby') do
  it { should be_file }
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
  it { should_not be_file }
end

describe file('/tmp/hnl_mk_dev-image.1.0.iso') do
  it { should_not be_file }
end

describe file('/tmp/hnl_mk_prod-image.1.0.iso') do
  it { should be_file }
end

describe file('/opt/hanlon') do
  it { should be_directory }
end

describe file('/opt/hanlon/embedded/hanlon/web/config/') do
  it { should be_directory }
end

describe service('hanlon') do
  it { should be_running }
end

describe port(8026) do
  it { should be_listening }
end

describe service('dnsmasq') do
  it { should be_running }
end

describe service('mongod') do
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end

describe command('curl http://localhost:8026/hanlon/api/v1/config') do
  it { should return_stdout /\"result\"\:\"Ok\"/ }
end
