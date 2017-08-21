#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-php-fpm
# Attribute:: default
#
# Copyright (C) 2017, Earth U
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

default['app-php-fpm']['version'] = '5.6' # or '5.5'
default['app-php-fpm']['delete_pool_www'] = true

default['app-php-fpm']['exts'] =
  case node['app-php-fpm']['version'].to_f
  when 5.5
    %w{ mysqlnd cli curl }
  when 5.6
    %w{ mysqlnd cli curl zip }
  end

default['app-php-fpm']['exts_rhel_only'] = %w{ xml mbstring }
default['app-php-fpm']['exts_debian_enmod_required'] = %w{ mcrypt }

default['app-php-fpm']['postfix']['update_cacert'] = true

default['php-fpm']['skip_repository_install']     = true
default['php-fpm']['emergency_restart_threshold'] = '10'
default['php-fpm']['emergency_restart_interval']  = '1m'
default['php-fpm']['process_control_timeout']     = '10s'
default['php-fpm']['pools'] = [
  {
    # Required attributes:
    :name   => 'example_pool',
    :enable => true,
    :listen => '/var/run/php-fpm.sock',
    #:listen => '127.0.0.1:9000',

    # Optional attributes with their defaults:

    #:max_requests => 500,
    #:max_children => 50,

    #:access_log           => false,
    #:catch_workers_output => 'no',

    #:process_manager => value_for_platform(
    #  'ubuntu'  => { '10.04' => 'dynamic' },
    #  'default' => 'ondemand'
    #),

    # Only used if process_manager is 'dynamic':
    #:start_servers     => 5,
    #:min_spare_servers => 5,
    #:max_spare_servers => 35,

    #:php_options => {
    #  'php_admin_value[cgi.fix_pathinfo]' => '0',
    #  'php_admin_value[expose_php]'       => 'Off',
    #  'php_value[upload_max_filesize]'    => '5M',
    #  'php_value[post_max_size]'          => '10M'
    #}
  }
]

default['mariadb']['install']['type']        = 'package'
default['mariadb']['install']['version']     = '10.0'
default['mariadb']['use_default_repository'] = true

default['postfix']['main']['myhostname']    = 'example.com'
default['postfix']['main']['mydomain']      = 'example.com'
default['postfix']['main']['myorigin']      = '$mydomain'
default['postfix']['main']['mydestination'] =
  %w{ localhost.localdomain localhost }
