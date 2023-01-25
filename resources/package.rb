#
# Cookbook:: app_php_fpm
# Resource:: package
#
# Copyright:: 2023, Earth U
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

# Install PHP-FPM using Ubuntu package

provides :php_package
unified_mode true

property :version, String, equal_to: %w(7.4 8.0 8.1),
         description: 'PHP version to install. '\
                      "Can be either '7.4', '8.0', or '8.1'.",
         name_property: true

property :repo_name, String,
         description: "Ondrej Sury's PHP repo name for Ubuntu",
         default: 'ppa:ondrej/php'

property :repo_key, String,
         description: 'Key of the PHP repo',
         default: 'E5267A6C'

property :conf_pid, String,
         description: 'Setting in php-fpm conf file. '\
                      "Defaults to: '/run/php/php{version}-fpm.pid'."

property :conf_error_log, String,
         description: 'Setting in php-fpm conf file. '\
                      "Defaults to: '/var/log/php{version}-fpm.log'."

# syslog_facility and syslog_ident are only used if error_log is set to 'syslog'
property :conf_syslog_facility, [String, nil],
         description: 'Setting in php-fpm conf file'

property :conf_syslog_ident, [String, nil],
         description: 'Setting in php-fpm conf file'

property :conf_log_level, [String, nil],
         description: 'Setting in php-fpm conf file',
         default: 'notice'

property :conf_log_limit, [Integer, nil],
         description: 'Setting in php-fpm conf file'

property :conf_emergency_restart_threshold, [Integer, nil],
         description: 'Setting in php-fpm conf file',
         default: 10

property :conf_emergency_restart_interval, [String, Integer, nil],
         description: 'Setting in php-fpm conf file',
         default: '1m'

property :conf_process_control_timeout, [String, Integer, nil],
         description: 'Setting in php-fpm conf file',
         default: '10s'

# process_max is only used for dynamix pm pools
property :conf_process_max, [Integer, nil],
         description: 'Setting in php-fpm conf file'

property :conf_rlimit_files, [Integer, nil],
         description: 'Setting in php-fpm conf file'

property :conf_rlimit_core, [String, Integer, nil],
         description: 'Setting in php-fpm conf file'

property :conf_events_mechanism, [String, nil],
         description: 'Setting in php-fpm conf file',
         default: 'epoll'

property :pool_name, String,
         description: 'Setting in pool conf file',
         default: 'www'

property :pool_user, String,
         description: "Setting in pool conf file. Defaults to: 'www-data'.",
         default: 'www-data'

property :pool_group, String,
         description: 'Setting in pool conf file. Defaults to: :pool_user.'

property :pool_listen, String,
         description: 'Setting in pool conf file'

property :pool_listen_owner, String,
         description: 'Setting in pool conf file'

property :pool_listen_group, String,
         description: 'Setting in pool conf file'

property :pool_listen_mode, String,
         description: 'Setting in pool conf file',
         default: '0660'

# listen_allowed_clients is only used if pool listens on a TCP socket
property :pool_listen_allowed_clients, [String, Array, nil],
         description: 'Setting in pool conf file',
         default: '127.0.0.1'

property :pool_pm, String, equal_to: %w(static dynamic ondemand),
         description: 'Setting in pool conf file',
         default: 'ondemand'

property :pool_pm_max_children, Integer,
         description: 'Setting in pool conf file',
         default: 50

property :pool_pm_max_requests, Integer,
         description: 'Setting in pool conf file',
         default: 500

# Only used when using 'dynamic' pm:
#   pm_start_servers   pm_min_spare_servers
#   pm_max_spawn_rate  pm_max_spare_servers
property :pool_pm_start_servers, [Integer, nil],
         description: 'Setting in pool conf file',
         default: 5

property :pool_pm_min_spare_servers, [Integer, nil],
         description: 'Setting in pool conf file',
         default: 5

property :pool_pm_max_spare_servers, [Integer, nil],
         description: 'Setting in pool conf file',
         default: 35

property :pool_pm_max_spawn_rate, [Integer, nil],
         description: 'Setting in pool conf file'

# Only used when using 'ondemand' pm:
#   pm_process_idle_timeout
property :pool_pm_process_idle_timeout, [String, nil],
         description: 'Setting in pool conf file',
         default: '10s'

property :pool_pm_status_path, [String, nil],
         description: 'Setting in pool conf file'

property :pool_pm_status_listen, [String, nil],
         description: 'Setting in pool conf file'

property :pool_ping_path, [String, nil],
         description: 'Setting in pool conf file'

property :pool_access_log, [String, nil],
         description: 'Setting in pool conf file'

property :pool_access_format, [String, nil],
         description: 'Setting in pool conf file'

property :pool_slowlog, [String, nil],
         description: 'Setting in pool conf file'

property :pool_request_slowlog_timeout, [String, nil],
         description: 'Setting in pool conf file'

property :pool_request_slowlog_trace_depth, [Integer, nil],
         description: 'Setting in pool conf file'

property :pool_request_terminate_timeout, [String, nil],
         description: 'Setting in pool conf file'

property :pool_request_terminate_timeout_track_finished, [String, nil],
         description: 'Setting in pool conf file'

property :pool_rlimit_files, [Integer, nil],
         description: 'Setting in pool conf file'

property :pool_rlimit_core, [String, Integer, nil],
         description: 'Setting in pool conf file'

property :pool_catch_workers_output, [String, nil], equal_to: ['yes', 'no', nil],
         description: 'Setting in pool conf file'

property :pool_clear_env, String, equal_to: %w(yes no),
         description: 'Setting in pool conf file',
         default: 'yes'

property :pool_php_options, Hash,
         description: 'Hash of additional PHP options in pool conf file'

action_class do
  def prop_conf_pid
    if property_is_set?(:conf_pid)
      new_resource.conf_pid
    else
      "/run/php/php#{new_resource.version}-fpm.pid"
    end
  end

  def prop_conf_error_log
    if property_is_set?(:conf_error_log)
      new_resource.conf_error_log
    else
      "/var/log/php#{new_resource.version}-fpm.log"
    end
  end

  def prop_pool_group
    if property_is_set?(:pool_group)
      new_resource.pool_group
    else
      new_resource.pool_user
    end
  end

  def prop_pool_listen
    if property_is_set?(:pool_listen)
      new_resource.pool_listen
    else
      "/run/php/php#{new_resource.version}-fpm.sock"
    end
  end

  def prop_pool_listen_owner
    if property_is_set?(:pool_listen_owner)
      new_resource.pool_listen_owner
    else
      new_resource.pool_user
    end
  end

  def prop_pool_listen_group
    if property_is_set?(:pool_listen_group)
      new_resource.pool_listen_group
    else
      prop_pool_group
    end
  end

  def prop_pool_listen_allowed_clients
    if new_resource.pool_listen_allowed_clients.is_a?(Array)
      new_resource.pool_listen_allowed_clients.join(',')
    else
      new_resource.pool_listen_allowed_clients
    end
  end

  def prop_pool_php_options
    if property_is_set?(:pool_php_options)
      new_resource.pool_php_options
    else
      {
        'php_admin_value[cgi.fix_pathinfo]' => '0',
        'php_admin_value[expose_php]'       => 'off',
        'php_value[upload_max_filesize]'    => '20M',
        'php_value[post_max_size]'          => '25M',
      }
    end
  end
end

action :install do
  fpm_dir   = "/etc/php/#{new_resource.version}/fpm"
  conf_file = "#{fpm_dir}/php-fpm.conf"
  pool_file = "#{fpm_dir}/pool.d/#{new_resource.pool_name}.conf"
  unit_name = "php#{new_resource.version}-fpm.service"

  vstr = {
    '7.4' => '74',
    '8.0' => '80',
    '8.1' => '81',
  }

  apt_repository 'ondrej-php' do
    uri        new_resource.repo_name
    components ['main']
    keyserver  'keyserver.ubuntu.com'
    key        new_resource.repo_key
  end

  package "php#{new_resource.version}-fpm"

  file "#{fpm_dir}/pool.d/www.conf" do
    action   :delete
    only_if  { ::File.exist?("#{fpm_dir}/pool.d/www.conf") }
    notifies :reload_or_restart, "systemd_unit[#{unit_name}]"
  end

  template conf_file do
    cookbook 'app_php_fpm'
    source   'php-fpm.conf.erb'
    owner    'root'
    group    'root'
    mode     '0644'
    notifies :reload_or_restart, "systemd_unit[#{unit_name}]"
    variables(
      pid:       prop_conf_pid,
      error_log: prop_conf_error_log,

      syslog_facility: new_resource.conf_syslog_facility,
      syslog_ident:    new_resource.conf_syslog_ident,
      log_level:       new_resource.conf_log_level,
      log_limit:       new_resource.conf_log_limit,

      emergency_restart_threshold: new_resource.conf_emergency_restart_threshold,
      emergency_restart_interval:  new_resource.conf_emergency_restart_interval,
      process_control_timeout:     new_resource.conf_process_control_timeout,
      process_max:                 new_resource.conf_process_max,

      rlimit_files:     new_resource.conf_rlimit_files,
      rlimit_core:      new_resource.conf_rlimit_core,
      events_mechanism: new_resource.conf_events_mechanism,

      poold: "#{fpm_dir}/pool.d"
    )
  end

  template pool_file do
    cookbook 'app_php_fpm'
    source   'pool.conf.erb'
    owner    'root'
    group    'root'
    mode     '0644'
    notifies :reload_or_restart, "systemd_unit[#{unit_name}]"
    variables(
      name:  new_resource.pool_name,
      user:  new_resource.pool_user,
      group: prop_pool_group,

      listen:                 prop_pool_listen,
      listen_owner:           prop_pool_listen_owner,
      listen_group:           prop_pool_listen_group,
      listen_mode:            new_resource.pool_listen_mode,
      listen_allowed_clients: prop_pool_listen_allowed_clients,

      pm:                      new_resource.pool_pm,
      pm_max_children:         new_resource.pool_pm_max_children,
      pm_start_servers:        new_resource.pool_pm_start_servers,
      pm_min_spare_servers:    new_resource.pool_pm_min_spare_servers,
      pm_max_spare_servers:    new_resource.pool_pm_max_spare_servers,
      pm_max_spawn_rate:       new_resource.pool_pm_max_spawn_rate,
      pm_process_idle_timeout: new_resource.pool_pm_process_idle_timeout,
      pm_max_requests:         new_resource.pool_pm_max_requests,

      pm_status_path:   new_resource.pool_pm_status_path,
      pm_status_listen: new_resource.pool_pm_status_listen,
      ping_path:        new_resource.pool_ping_path,

      access_log:                  new_resource.pool_access_log,
      access_format:               new_resource.pool_access_format,
      slowlog:                     new_resource.pool_slowlog,
      request_slowlog_timeout:     new_resource.pool_request_slowlog_timeout,
      request_slowlog_trace_depth: new_resource.pool_request_slowlog_trace_depth,

      request_terminate_timeout:                new_resource.pool_request_terminate_timeout,
      request_terminate_timeout_track_finished: new_resource.pool_request_terminate_timeout_track_finished,

      rlimit_files:         new_resource.pool_rlimit_files,
      rlimit_core:          new_resource.pool_rlimit_core,
      catch_workers_output: new_resource.pool_catch_workers_output,
      clear_env:            new_resource.pool_clear_env,

      php_options: prop_pool_php_options
    )
  end

  service = {
    Type:       'notify',
    ExecStart:  "/usr/sbin/php-fpm#{new_resource.version} "\
                "--nodaemonize --fpm-config #{conf_file}",
    ExecReload: '/bin/kill -USR2 $MAINPID',
  }
  # If listening on a local unix socket:
  if prop_pool_listen.start_with?('/')
    com = '-/usr/lib/php/php-fpm-socket-helper %s /run/php/php-fpm.sock '\
          "#{pool_file} #{vstr[new_resource.version]}"

    service[:ExecStartPost] = format(com, ['install'])
    service[:ExecStopPost]  = format(com, ['remove'])
  end

  unit = {
    Unit: {
      Description:   "PHP #{new_resource.version} FPM (Managed by Chef)",
      Documentation: "man:php-fpm#{new_resource.version}(8)",
      After:         'network.target',
    },
    Service: service,
    Install: {
      WantedBy: 'multi-user.target',
    },
  }

  systemd_unit unit_name do
    content unit
    verify  true
    action  [:create, :enable]
  end
end

action :remove do
  systemd_unit "php#{new_resource.version}-fpm.service" do
    action [:disable, :delete]
  end

  package "php#{new_resource.version}-fpm" do
    action         :purge
    ignore_failure true
  end
end
