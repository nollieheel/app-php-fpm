#
# Cookbook:: app_php_fpm
# Resource:: repo
#
# Copyright:: 2026, Earth U
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

# Set up the packages.sury.org PHP repository
# Based on: https://packages.sury.org/php/README.txt

provides :php_repo
unified_mode true

property :cache_rebuild, [true, false],
         description: 'Automatically update cache after adding repo',
         default: true

action :configure do
  # The README installs 'lsb-release', 'ca-certificates', and 'curl' first.
  # They are not installed here:
  #   - curl:        replaced by the remote_file resource below
  #   - lsb-release: replaced by apt_repository's distribution default
  #                  (the node's LSB codename)
  #   - ca-certificates: not installed by this resource
  #
  # The README's 'apt-get update' commands are also not run here. The
  # repo cache rebuild is controlled by the :cache_rebuild property.

  keyring_deb = "#{Chef::Config[:file_cache_path]}/debsuryorg-archive-keyring.deb"

  remote_file keyring_deb do
    source 'https://packages.sury.org/debsuryorg-archive-keyring.deb'
  end

  dpkg_package 'debsuryorg-archive-keyring' do
    source keyring_deb
  end

  apt_repository 'php' do
    uri           'https://packages.sury.org/php/'
    components    ['main']
    options       ['signed-by=/usr/share/keyrings/debsuryorg-archive-keyring.gpg']
    keyserver     false
    cache_rebuild new_resource.cache_rebuild
  end
end
