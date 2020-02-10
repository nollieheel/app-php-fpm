# # encoding: utf-8

describe command('composer --version') do
  its('stdout') { should match /Composer version 1\.9\.3/ }
end

describe service('php7.2-fpm.service') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/run/php/php7.2-fpm.pid') do
  it { should exist }
end

describe file('/run/php/php7.2-fpm.sock') do
  it { should exist }
  its('type') { should eq :socket }
end

describe http('http://localhost') do
  its('status') { should eq 200 }
end

%w{
  mysqlnd
  curl
  zip
  mbstring
}.each do |x|
  describe command("php -m | grep #{x}") do
    its('exit_status') { should eq 0 }
  end
end

describe command('mysql') do
  it { should exist }
end
