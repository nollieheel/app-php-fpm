#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-php-fpm
# Resource:: exts
#
# Copyright (C) 2018, Earth U
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

# Install PHP extensions

property :exts, [Array, String], name_property: true
property :version, String, default: lazy { node['app-php-fpm']['version'] }
property :rhel_only, Array, default: lazy { node['app-php-fpm']['exts']['rhel_only'] }

action :install do

  prefix = new_resource.version == '5.6' ? 'php5.6-' : 'php5-'

  if new_resource.exts.is_a?(Array)
    exs = new_resource.exts
  else
    if new_resource.exts.count(',') > 0
      exs = new_resource.exts.delete(' ').split(',')
    else
      exs = [ new_resource.exts ]
    end
  end

  exs.each do |ex|
    case node['platform']
    when 'ubuntu'
      unless new_resource.rhel_only.include?(ex)
        package "#{prefix}#{ex}"
      end

    else
      Chef::Application.fatal!("Unsupported platform: #{node['platform']}")
    end
  end

end
