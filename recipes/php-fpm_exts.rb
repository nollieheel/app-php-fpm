#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-php-fpm
# Recipe:: php-fpm_exts
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

node['app-php-fpm']['exts'].each do |ext|
  case node['platform_family']
  when 'rhel', 'fedora'
    package "php-#{params[:name]}" do
      action params[:action]
    end

  when 'debian'
    if node['platform'] == 'ubuntu' &&
       node['app-php-fpm']['version'] == '5.6'
      packpref = 'php5.6-'
      enmod = 'phpenmod'
    else
      packpref = 'php5-'
      enmod = 'php5enmod'
    end

    unless node['app-php-fpm']['exts_rhel_only'].include?(ext)
      package "#{packpref}#{ext}"

      if node['app-php-fpm']['exts_debian_enmod_required'].include?(ext)
        execute "#{enmod} #{ext}" do
          notifies :restart, 'service[php-fpm]', :immediately
        end
      end
    end
  end
end
