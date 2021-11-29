#
# Cookbook:: app_php_fpm
# Resource:: ext
#
# Copyright:: 2022, Earth U
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

# Install PHP extensions

provides :php_ext
unified_mode true

# Example: ['mysql', 'curl', 'zip', 'mbstring']
property :ext_name, [Array, String],
         description: 'Name of PHP-FPM extension/s to install. Can also be '\
                      'a string of multiple ext names separated by comma, '\
                      'or an array of ext names.',
         name_property: true

property :php_version, String, required: true,
         description: 'PHP-PFM version'

action_class do

  # If an array of strings is passed as the resource name,
  # it gets automatically join(', ')-ed.
  def get_ext_names
    if new_resource.ext_name.is_a?(Array)
      new_resource.ext_name.map { |s| s.strip }
    else
      new_resource.ext_name.split(',').map { |s| s.strip }
    end
  end
end

action :install do
  get_ext_names().each do |n|
    package "php#{new_resource.php_version}-#{n}"
  end
end

action :remove do
  get_ext_names().each do |n|
    package "php#{new_resource.php_version}-#{n}" do
      action :remove
    end
  end
end
