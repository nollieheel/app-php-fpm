#
# Cookbook:: app_php_fpm
# Resource:: composer
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

# Install the Composer binary
# Inspired by https://github.com/djoos-cookbooks/composer

provides :php_composer
unified_mode true

# Usually: '1.9.3', '1.10.23', or the latest '2.3.7'
property :version, String,
         description: 'Version of Composer to install',
         name_property: true

property :download_url, String,
         description: 'String template for the remote location of composer.phar',
         default: 'https://getcomposer.org/download/%s/composer.phar'

property :install_dir, String,
         description: 'Install location for Composer',
         default: '/usr/local/bin'

action :install do

  cfile = "#{new_resource.install_dir}/composer"
  remote_file cfile do
    source new_resource.download_url % [new_resource.version]
    mode   '0755'
    not_if { ::File.exist?(cfile) }
  end
end
