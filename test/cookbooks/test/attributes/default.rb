#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: test
# Attribute:: default
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

default['composer']['url'] =
  'https://getcomposer.org/download/1.9.3/composer.phar'

default['app-php-fpm']['version'] = '7.2'
default['app-php-fpm']['exts'] = %w{ mysqlnd cli curl zip mbstring }
default['app-php-fpm']['mariadb']['version'] = '10.1'

default['php-fpm']['pool'] = {
  name: 'test_pool',
}
