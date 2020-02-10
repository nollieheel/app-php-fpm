#
# Author:: Earth U (<iskitingbords@gmail.com>)
# Cookbook Name:: app-php-fpm
# Recipe:: mariadb_client
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

mariadb_repository 'mariadb_repo' do
  version            node['app-php-fpm']['mariadb']['version']
  apt_repository_uri node['app-php-fpm']['mariadb']['repo']
end

mariadb_client_install 'mariadb_client' do
  version    node['app-php-fpm']['mariadb']['version']
  setup_repo false
end
