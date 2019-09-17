#
# Author:: Earth U (<iskitingbords @ gmail.com>)
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

def mash_to_hash(mash)
  mash.inject({}) do |acc, (k, v)|
    acc[k] = v.is_a?(Hash) ? mash_to_hash(v) : v
    acc
  end
end

apt_repository 'ondrej-php' do
  uri          'ppa:ondrej/php'
  distribution node['lsb']['codename']
  components   ['main']
  keyserver    'keyserver.ubuntu.com'
  key          'E5267A6C'
end

# Set derived attribute defaults inside recipe

v = node['app-php-fpm']['version']

node.default['php-fpm']['conf_file']     = "/etc/php/#{v}/fpm/php-fpm.conf"
node.default['php-fpm']['conf_dir']      = "/etc/php/#{v}/fpm/conf.d"
node.default['php-fpm']['pool_conf_dir'] = "/etc/php/#{v}/fpm/pool.d"
node.default['php-fpm']['pid']           = "/var/run/php#{v}-fpm.pid"
node.default['php-fpm']['package_name']  = "php#{v}-fpm"
node.default['php-fpm']['service_name']  = "php#{v}-fpm"

if node['php-fpm']['pools']
  def_php_opts = {
    'php_admin_value[cgi.fix_pathinfo]' => '0',
    'php_admin_value[expose_php]'       => 'Off',
    'php_value[upload_max_filesize]'    => '10M',
    'php_value[post_max_size]'          => '10M'
  }

  is_hash = node['php-fpm']['pools'].is_a?(Hash) # either Hash or Array
  meth = node['php-fpm']['pools'].method( is_hash ? :each : :each_with_index )
  meth.call do |el1, el2|
    key   = is_hash ? el1 : el2
    pool  = is_hash ? el2 : el1
    pool2 = mash_to_hash(pool)

    pool2['process_manager'] = 'ondemand' unless pool['process_manager']
    pool2['max_requests']    = 500 unless pool['max_requests']
    pool2['php_options']     = def_php_opts unless pool['php_options']

    node.default['php-fpm']['pools'][key] = pool2
  end
end

# Begin server configuration

include_recipe 'php-fpm'

if node['app-php-fpm']['delete_pool_www']
  www = "#{node['php-fpm']['pool_conf_dir']}/www.conf"
  file 'delete_pool_www' do
    path     www
    action   :delete
    only_if  { ::File.exist?(www) }
    notifies :restart, 'service[php-fpm]'
  end
end
