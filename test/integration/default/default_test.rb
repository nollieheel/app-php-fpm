# Reading node attribs
p = json('/tmp/kitchen_chef_node.json').params

vdef = p['default'].key?('test') ? p['default']['test'] : {}
vnor = p['normal'].key?('test') ? p['normal']['test'] : {}
vove = p['override'].key?('test') ? p['override']['test'] : {}
v    = (vdef.merge(vnor)).merge(vove)

describe command('composer --version') do
  #its('stdout') { should match /Composer version 2\.3\.7/ }
  its('stdout') { should match /Composer version #{v['composer_version']}/ }
end

php_str = "php#{v['php_version']}-fpm"

#describe service('php8.1-fpm.service') do
describe service("#{php_str}.service") do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

#describe file('/run/php/php8.1-fpm.pid') do
describe file("/run/php/#{php_str}.pid") do
  it { should exist }
end

#describe file('/run/php/php8.1-fpm.sock') do
describe file("/run/php/#{php_str}.sock") do
  it { should exist }
  its('type') { should eq :socket }
end

describe http('http://localhost') do
  its('status') { should eq 200 }
end

#%w(
#  mysql
#  curl
#  zip
#  mbstring
#).each do |x|
v['php_exts'].each do |x|
  describe command("php -m | grep #{x}") do
    its('exit_status') { should eq 0 }
  end
end

describe command('mysql') do
  it { should exist }
end
