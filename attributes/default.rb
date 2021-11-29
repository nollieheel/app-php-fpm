#
# Cookbook:: app_php_fpm
# Attribute:: default
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

# --- Tips for Postfix config ---
# (depends 'postfix', '~> 5.3.1')
#
# If using a localhost mailserver, use the following:
#default['postfix']['main']['myhostname']    = 'example.com'
#default['postfix']['main']['mydomain']      = 'example.com'
#default['postfix']['main']['myorigin']      = '$mydomain'
#default['postfix']['main']['mydestination'] =
#  %w{ localhost.localdomain localhost }

# If using AWS SES, use the following:
#default['postfix']['master']['relay']['args'] = []

#default['postfix']['main']['smtp_use_tls']                 = 'yes'
#default['postfix']['main']['smtp_tls_security_level']      = 'encrypt'
#default['postfix']['main']['smtp_tls_note_starttls_offer'] = 'yes'

#default['postfix']['main']['smtp_sasl_auth_enable'] = 'yes'
#override['postfix']['sasl']['smtp_sasl_user_name']  = 'theusername'
#override['postfix']['sasl']['smtp_sasl_passwd']     = 'thepassword'
#override['postfix']['main']['relayhost'] =
#  '[email-smtp.us-east-1.amazonaws.com]:25'
