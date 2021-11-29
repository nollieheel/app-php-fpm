#
# Cookbook:: app_php_fpm
# Resource:: mariadb_client
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

# Install Mariadb client CLI

provides :php_mariadb_client
unified_mode true

property :version, equal_to: ['10.4', '10.5', '10.6', '10.7', '10.8'],
         description: 'MariaDB client version to install',
         name_property: true

# Locations taken from:
#     https://downloads.mariadb.org/mariadb/repositories/#mirror=utm
property :repo_region, equal_to: ['east', 'west'],
         description: "Repo region location. Can be either 'east' or 'west'.",
         default: 'west'

action_class do
  def repo_location
    lmap = {
      'east' => 'http://nyc2.mirrors.digitalocean.com/mariadb/repo',
      'west' => 'http://sfo1.mirrors.digitalocean.com/mariadb/repo',
    }
    lmap[new_resource.repo_region]
  end
end

action :install do

  mariadb_repository 'mariadb_repo' do
    version            new_resource.version
    apt_repository_uri repo_location
  end

  mariadb_client_install 'mariadb_client' do
    version    new_resource.version
    setup_repo false
  end
end
