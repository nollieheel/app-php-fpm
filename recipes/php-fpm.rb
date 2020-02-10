#
# Author:: Earth U (<iskitingbords@gmail.com>)
# Cookbook Name:: app-php-fpm
# Recipe:: php-fpm
#
# Copyright (C) 2020, Earth U
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Install repository

apt_repository 'ondrej-php' do
  uri          node['app-php-fpm']['repo_uri']
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          node['app-php-fpm']['repo_key']
end

# Install package

v = node['app-php-fpm']['version']

package_name = node['app-php-fpm']['package_name'] || "php#{v}-fpm"
service_name = node['app-php-fpm']['service_name'] || package_name

package package_name do
  if node['app-php-fpm']['package_ver']
    version node['app-php-fpm']['package_ver']
  end
end

service(service_name) { action :nothing }

# Configure

error_log = node['app-php-fpm']['error_log'] || "/var/log/php#{v}-fpm.log"
fpm_dir = node['app-php-fpm']['fpm_dir'] || "/etc/php/#{v}/fpm"

poold = "#{fpm_dir}/pool.d"
confd = "#{fpm_dir}/conf.d"
conf_file = "#{fpm_dir}/php-fpm.conf"
unit_file = "/lib/systemd/system/php#{v}-fpm.service"

bin = node['app-php-fpm']['bin'] || "/usr/sbin/php-fpm#{v}"
pid = node['app-php-fpm']['pid'] || "/run/php/php#{v}-fpm.pid"
socket = node['app-php-fpm']['socket'] || "/run/php/php#{v}-fpm.sock"
unix_socket = socket.start_with?('/') ? socket : false

file "#{poold}/www.conf" do
  action   :delete
  only_if  { ::File.exist?("#{poold}/www.conf") }
  notifies :restart, "service[#{service_name}]"
end

template conf_file do
  owner 'root'
  mode  '0644'
  variables(
    vars: node['app-php-fpm']['conf'],
    more_defaults: {
      pid:       pid,
      error_log: error_log,
      poold:     poold,
    },
  )
  notifies :restart, "service[#{service_name}]"
end

template "#{poold}/#{node['app-php-fpm']['pool'][:name]}.conf" do
  source 'pool.conf.erb'
  owner  'root'
  mode   '0644'
  variables(
    vars: node['app-php-fpm']['pool'],
    more_defaults: {
      listen: socket,
    },
  )
  notifies :restart, "service[#{service_name}]"
end

execute 'daemon_reload' do
  command 'systemctl daemon-reload'
  action  :nothing
end

template unit_file do
  source 'php-fpm.service.erb'
  owner  'root'
  mode   '0644'
  variables(
    version:     v,
    pidfile:     pid,
    bin:         bin,
    conf_file:   conf_file,
    unix_socket: unix_socket,
  )
  notifies :run, 'execute[daemon_reload]', :immediately
end
