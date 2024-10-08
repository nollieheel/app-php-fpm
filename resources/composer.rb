#
# Cookbook:: app_php_fpm
# Resource:: composer
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

# Install the Composer binary
# Inspired by https://github.com/djoos-cookbooks/composer

provides :php_composer
unified_mode true

# Usually: '1.9.3', '1.10.27', or the latest '2.7.7'
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
  remote_file "#{new_resource.install_dir}/composer" do
    action :create_if_missing
    source format(new_resource.download_url, new_resource.version)
    mode   '0755'
  end
end
