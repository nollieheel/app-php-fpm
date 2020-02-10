#
# Author:: Earth U (<iskitingbords@gmail.com>)
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

default['app-php-fpm']['version'] = '7.3'

default['app-php-fpm']['repo_uri'] = value_for_platform(
  'default' => false,
  'ubuntu'  => {'default' => 'ppa:ondrej/php'},
)
default['app-php-fpm']['repo_key'] = value_for_platform(
  'default' => false,
  'ubuntu'  => {'default' => 'E5267A6C'},
)

# A specific package version can be specified here:
#default['app-php-fpm']['package_ver'] = '7.3.14-6+ubuntu16.04.1+deb.sury.org+1'

default['app-php-fpm']['exts'] = %w{ mysqlnd cli curl zip }

## PIDFILE ##
# pid setting in php-fpm.conf can be manually set by node attribute:
#   default['app-php-fpm']['pid']
# The default is determinted by PHP version:
#   "/run/php/php#{version}-fpm.pid"

## ERRORLOG ##
# error_log setting in php-fpm.conf can be manually set by node attribute:
#   default['app-php-fpm']['error_log']
# The default is determinted by PHP version:
#   "/var/log/php#{version}-fpm.log"

# The rest of php-fpm.conf settings and their defaults:
default['app-php-fpm']['conf'] = {

  #log_level: 'notice',
  #log_limit: nil,

  # Only used if error_log is set to 'syslog':
  #syslog_facility: nil,
  #syslog_ident:    nil,

  #emergency_restart_threshold: 10,
  #emergency_restart_interval:  '1m',
  #process_control_timeout:     '10s',

  # Only when using dynamic pm pools:
  #process_max: nil,

  #rlimit_files:     nil,
  #rlimit_core:      nil,
  #events_mechanism: 'epoll',
}

## PHP LISTEN SOCKET ##
# Socket can be manually set by node attribute.
# This will be used as the 'listen' config in the pool definition.
#   default['app-php-fpm']['socket']
# The default is a unix socket filename determined by PHP version:
#   "/run/php/php#{version}-fpm.sock"

# The rest of pool settings and their defaults (if optional):
default['app-php-fpm']['pool'] = {

  # Mandatory property:
  name:  'www',

  #user:  'www-data',
  #group: 'www-data',

  # Only when using unix socket:
  #listen_owner: {same as user},
  #listen_group: {same as group},
  #listen_mode:  '0660',

  # Only when using tcp socket:
  #listen_allowed_clients: '127.0.0.1',

  #pm: 'ondemand',
  #pm_max_requests: 500,
  #pm_max_children: 50,

  # Only when using pm = 'ondemand':
  #pm_process_idle_timeout: '10s',

  # Only when using pm = 'dynamic':
  #:pm_start_servers:     5,
  #:pm_min_spare_servers: 5,
  #:pm_max_spare_servers: 35,

  #clear_env: 'yes',
  #pm_status_path: nil,
  #ping_path:      nil,

  #access_log:    nil,
  #access_format: nil,

  #slowlog:                                  nil,
  #request_slowlog_timeout:                  nil,
  #request_slowlog_trace_depth:              nil,
  #request_terminate_timeout:                nil,
  #request_terminate_timeout_track_finished: nil,

  #rlimit_files:         nil,
  #rlimit_core:          nil,
  #catch_workers_output: nil,

  #security_limit_extensions: '.php',

  #php_options: {
  #  'php_admin_value[cgi.fix_pathinfo]' => '0',
  #  'php_admin_value[expose_php]'       => 'Off',
  #  'php_value[upload_max_filesize]'    => '20M',
  #  'php_value[post_max_size]'          => '25M'
  #},
}

default['app-php-fpm']['composer']['install_dir'] = '/usr/local/bin'
default['app-php-fpm']['composer']['url'] =
  'https://getcomposer.org/download/1.9.3/composer.phar'

# Get repos here: https://downloads.mariadb.org/mariadb/repositories/#mirror=utm
default['app-php-fpm']['mariadb']['repo'] =
  'http://nyc2.mirrors.digitalocean.com/mariadb/repo' # New York
  #'http://sfo1.mirrors.digitalocean.com/mariadb/repo' # San Francisco
default['app-php-fpm']['mariadb']['version'] = '10.4'

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
