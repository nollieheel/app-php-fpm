#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: test
# Recipe:: default
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

include_recipe 'app-php-fpm::default'
package 'nginx-light'

cookbook_file '/etc/nginx/sites-available/default' do
  source 'nginx.conf'
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
