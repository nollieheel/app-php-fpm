#
# Cookbook:: test
# Recipe:: default
#
# Copyright:: 2024, Earth U
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

# Save node attribs to file
ruby_block 'save node attribs' do
  block do
    ::File.write('/tmp/kitchen_chef_node.json', node.to_json)
  end
end

vs = node[cookbook_name]

php_package vs['php_version'] do
  pool_name vs['pool_name']
  pool_user vs['pool_user']
end

php_ext vs['php_exts'] do
  php_version vs['php_version']
end

php_composer vs['composer_version']

package 'nginx-light'

template '/etc/nginx/sites-available/default' do
  source 'nginx.conf.erb'
  variables(
    version: vs['php_version']
  )
end

service 'nginx' do
  action :restart
end

directory '/var/www' do
  recursive true
end

file '/var/www/index.php' do
  content '<?php phpinfo(); ?>'
  owner   'www-data'
  group   'www-data'
end
