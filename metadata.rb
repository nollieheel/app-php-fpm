name             'app_php_fpm'
maintainer       'Earth U'
maintainer_email 'iskitingbords@gmail.com'
license          'Apache-2.0'
description      'Just a wrapper for setting up PHP-FPM-based apps'
source_url       'https://github.com/nollieheel/app-php-fpm'
issues_url       'https://github.com/nollieheel/app-php-fpm/issues'
version          '6.0.0'

depends 'app_add_apt', '~> 1.0.0'

chef_version '>= 17.0'
supports     'ubuntu', '22.04'
supports     'ubuntu', '24.04'
