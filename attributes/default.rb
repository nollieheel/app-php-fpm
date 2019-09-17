#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-php-fpm
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

default['app-php-fpm']['version'] = '7.2'
default['app-php-fpm']['delete_pool_www'] = true

# Install extensions by default
default['app-php-fpm']['exts'] = %w{ mysqlnd cli curl zip }

# Get repos here: https://downloads.mariadb.org/mariadb/repositories/#mirror=utm
default['app-php-fpm']['mariadb']['repo'] =
  'http://nyc2.mirrors.digitalocean.com/mariadb/repo' # 10.1, New York
  #'http://sfo1.mirrors.digitalocean.com/mariadb/repo' # 10.1, San Francisco
default['app-php-fpm']['mariadb']['version'] = '10.1'

# Running the composer recipe auto-runs this recipe:
default['composer']['php_recipe'] = 'app-php-fpm::php-fpm'

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

    #:process_manager => 'ondemand',

    # Only used if process_manager is 'dynamic':
    #:start_servers     => 5,
    #:min_spare_servers => 5,
    #:max_spare_servers => 35,

    #:php_options => {
    #  'php_admin_value[cgi.fix_pathinfo]' => '0',
    #  'php_admin_value[expose_php]'       => 'Off',
    #  'php_value[upload_max_filesize]'    => '10M',
    #  'php_value[post_max_size]'          => '15M'
    #}
  }
]
default['php-fpm']['skip_repository_install']     = true
# If 10 child processes fail within 1m, restart main php-fpm process:
default['php-fpm']['emergency_restart_threshold'] = '10'
default['php-fpm']['emergency_restart_interval']  = '1m'
# Max grace period for child processes before executing a
# signal received from parent:
default['php-fpm']['process_control_timeout']     = '10s'

# --- Tips for Postfix config ---
# (depends 'postfix', '~> 5.3.1')
#
# If using a localhost mailserver, use the following:
#default['postfix']['main']['myhostname']    = 'example.com'
#default['postfix']['main']['mydomain']      = 'example.com'
#default['postfix']['main']['myorigin']      = '$mydomain'
#default['postfix']['main']['mydestination'] =
#  %w{ localhost.localdomain localhost }

# If using AWS SES, use the following:
#default['postfix']['master']['relay']['args'] = []

#default['postfix']['main']['smtp_use_tls']                 = 'yes'
#default['postfix']['main']['smtp_tls_security_level']      = 'encrypt'
#default['postfix']['main']['smtp_tls_note_starttls_offer'] = 'yes'

#default['postfix']['main']['smtp_sasl_auth_enable'] = 'yes'
#override['postfix']['sasl']['smtp_sasl_user_name']  = 'theusername'
#override['postfix']['sasl']['smtp_sasl_passwd']     = 'thepassword'
#override['postfix']['main']['relayhost'] =
#  '[email-smtp.us-east-1.amazonaws.com]:25'
