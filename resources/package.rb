#
# Cookbook:: app_php_fpm
# Resource:: package
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

# Install PHP-FPM using Ubuntu package

provides :php_package
unified_mode true

property :version, String, equal_to: %w(7.4 8.0 8.1 8.2 8.3),
         description: 'PHP version to install. '\
                      "Can be one of: '7.4', '8.0', '8.1', '8.2', '8.3'",
         name_property: true

property :install_repo, [true, false],
         description: 'Whether or not to set up PHP-FPM repo',
         default: true

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
         callbacks: { 'must not be www' => ->(p) { p != 'www' } },
         default: 'exampool'

property :pool_user, String,
         description: "Setting in pool conf file. Defaults to: 'www-data'.",
         default: 'www-data'

property :pool_group, String,
         description: 'Setting in pool conf file. Defaults to: :pool_user.'

property :pool_listen, String,
         description: 'Setting in pool conf file. '\
                      "Defaults to: '/run/php/php{version}-fpm.sock'."

property :pool_listen_owner, String,
         description: 'Setting in pool conf file. Defaults to: :pool_user.'

property :pool_listen_group, String,
         description: 'Setting in pool conf file. Defaults to: :pool_group.'

property :pool_listen_mode, String,
         description: 'Setting in pool conf file',
         default: '0660'

# listen_allowed_clients is only used if pool listens on a TCP socket
property :pool_listen_allowed_clients, [String, Array],
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
         default: 400

# Only used when using 'dynamic' pm:
#   pm_start_servers
#   pm_min_spare_servers
#   pm_max_spare_servers
#   pm_max_spawn_rate
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

property :pool_ping_response, [String, nil],
         description: 'Setting in pool conf file'

property :pool_access_log, [String, nil],
         description: 'Setting in pool conf file'

property :pool_access_format, [String, nil],
         description: 'Setting in pool conf file'

property :pool_access_suppress_path, [String, Array],
         description: 'Setting in pool conf file',
         default: []

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
         description: 'Hash of additional PHP options in pool conf file',
         default: {
           'php_admin_value[cgi.fix_pathinfo]' => '0',
           'php_admin_value[expose_php]'       => 'off',
           'php_value[upload_max_filesize]'    => '20M',
           'php_value[post_max_size]'          => '25M',
         }

action_class do
  def getdef(prop, default)
    property_is_set?(prop) ? new_resource.send(prop) : default
  end

  def unit_name
    "php#{new_resource.version}-fpm.service"
  end
end

action :install do
  if new_resource.install_repo
    php_repo 'app_php_fpm_repo'
  end

  package "php#{new_resource.version}-fpm"
  package %w(zip unzip 7zip)

  fpm_dir   = "/etc/php/#{new_resource.version}/fpm"
  conf_file = "#{fpm_dir}/php-fpm.conf"
  pool_file = "#{fpm_dir}/pool.d/#{new_resource.pool_name}.conf"

  file "#{fpm_dir}/pool.d/www.conf" do
    action  :delete
    only_if { ::File.exist?("#{fpm_dir}/pool.d/www.conf") }
  end

  prop_conf_pid =
    getdef(:conf_pid, "/run/php/php#{new_resource.version}-fpm.pid")
  prop_conf_error_log =
    getdef(:conf_error_log, "/var/log/php#{new_resource.version}-fpm.log")

  template conf_file do
    cookbook 'app_php_fpm'
    source   'php-fpm.conf.erb'
    owner    'root'
    group    'root'
    mode     '0644'
    notifies :restart, "systemd_unit[#{unit_name}]"
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

      poold: ::File.dirname(pool_file)
    )
  end

  prop_pool_group        = getdef(:pool_group, new_resource.pool_user)
  prop_pool_listen_owner = getdef(:pool_listen_owner, new_resource.pool_user)
  prop_pool_listen_group = getdef(:pool_listen_group, prop_pool_group)
  prop_pool_listen       =
    getdef(:pool_listen, "/run/php/php#{new_resource.version}-fpm.sock")

  template pool_file do
    cookbook 'app_php_fpm'
    source   'pool.conf.erb'
    owner    'root'
    group    'root'
    mode     '0644'
    notifies :restart, "systemd_unit[#{unit_name}]"
    variables(
      name:  new_resource.pool_name,
      user:  new_resource.pool_user,
      group: prop_pool_group,

      listen:                 prop_pool_listen,
      listen_owner:           prop_pool_listen_owner,
      listen_group:           prop_pool_listen_group,
      listen_mode:            new_resource.pool_listen_mode,
      listen_allowed_clients: new_resource.pool_listen_allowed_clients,

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
      ping_response:    new_resource.pool_ping_response,

      access_log:                  new_resource.pool_access_log,
      access_format:               new_resource.pool_access_format,
      access_suppress_path:        new_resource.pool_access_suppress_path,
      slowlog:                     new_resource.pool_slowlog,
      request_slowlog_timeout:     new_resource.pool_request_slowlog_timeout,
      request_slowlog_trace_depth: new_resource.pool_request_slowlog_trace_depth,

      request_terminate_timeout:                new_resource.pool_request_terminate_timeout,
      request_terminate_timeout_track_finished: new_resource.pool_request_terminate_timeout_track_finished,

      rlimit_files:         new_resource.pool_rlimit_files,
      rlimit_core:          new_resource.pool_rlimit_core,
      catch_workers_output: new_resource.pool_catch_workers_output,
      clear_env:            new_resource.pool_clear_env,

      php_options: new_resource.pool_php_options
    )
  end

  service = {
    Type:       'notify',
    ExecStart:  "/usr/sbin/php-fpm#{new_resource.version} "\
                "--nodaemonize --fpm-config #{conf_file}",
    ExecReload: '/bin/kill -USR2 $MAINPID',
    Restart:    'on-failure',
  }

  # If listening on a local unix socket:
  if prop_pool_listen.start_with?('/')
    com = '-/usr/lib/php/php-fpm-socket-helper %s /run/php/php-fpm.sock '\
          "#{pool_file} #{new_resource.version.delete('.')}"

    service[:ExecStartPost] = com % 'install'
    service[:ExecStopPost]  = com % 'remove'
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
  systemd_unit unit_name do
    action [:disable, :delete]
  end

  package "php#{new_resource.version}-fpm" do
    action         :purge
    ignore_failure true
  end
end
