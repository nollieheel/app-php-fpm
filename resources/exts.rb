#
# Author:: Earth U (<iskitingbords @ gmail.com>)
# Cookbook Name:: app-php-fpm
# Resource:: exts
#
# Copyright (C) 2019, Earth U
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

action :install do

  prefix = 'php-'
  if platform?('ubuntu')
    if new_resource.version == '5.5'
      prefix = 'php5-'
    else
      prefix = "php#{new_resource.version}-"
    end
  end

  if new_resource.exts.is_a?(Array)
    exs = new_resource.exts
  else
    if new_resource.exts.count(',') > 0
      exs = new_resource.exts.delete(' ').split(',')
    else
      exs = [ new_resource.exts ]
    end
  end
  if not platform_family?('rhel')
    exs = exs - node['app-php-fpm']['exts_rhel_only']
  end

  exs.each do |ex|
    package "#{prefix}#{ex}"
  end
end