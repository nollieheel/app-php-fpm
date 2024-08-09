#
# Cookbook:: app_php_fpm
# Resource:: repo
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

# Set up Ondrej's repo

provides :php_repo
unified_mode true

property :cache_rebuild, [true, false],
         description: 'Automatically update cache after adding repo',
         default: true

action :configure do
  if node['platform_version'] == '22.04'
    add_apt 'ondrej-php' do
      key           'B8DC7E53946656EFBCE4C1DD71DAEAAB4AD4CAB6'
      uri           'https://ppa.launchpadcontent.net/ondrej/php/ubuntu'
      components    ['main']
      cache_rebuild new_resource.cache_rebuild
    end

  elsif node['platform_version'] == '24.04'
    f = new_resource.cache_rebuild ? '' : '-n '

    # As of Chef Infra 18.5.0, the apt_repository resource will still use
    # the deprecated integrated keys method in Ubuntu 24.04.
    #
    # We use the apt-add-repository command, instead:
    execute 'apt-add-repository %sppa:ondrej/php' % f
  end
end
