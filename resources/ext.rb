#
# Author:: Earth U (<iskitingbords@gmail.com>)
# Cookbook Name:: app-php-fpm
# Resource:: ext
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

# Install PHP extensions

resource_name :php_ext
default_action :install

property :name, [Array, String], name_property: true
property :php_version, String, default: lazy { node['app-php-fpm']['version'] }

action_class do
  def get_names
    if new_resource.name.is_a?(Array)
      new_resource.name
    else
      new_resource.name.split(' ')
    end
  end
end

action :install do
  get_names().each do |n|
    package "php#{new_resource.php_version}-#{n}"
  end
end

action :remove do
  get_names().each do |n|
    package "php#{new_resource.php_version}-#{n}" do
      action :remove
    end
  end
end
