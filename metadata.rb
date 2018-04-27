name             'app-php-fpm'
maintainer       'Earth U'
maintainer_email 'iskitingbords @ gmail.com'
license          'Apache License'
description      'Just a wrapper for setting up PHP-FPM-based apps'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/app-php-fpm'
issues_url       'https://github.com/nollieheel/app-php-fpm/issues'
version          '0.2.0'

depends 'php-fpm', '~> 0.7.9'
depends 'mariadb', '~> 1.5.3'
depends 'postfix', '~> 5.2.1'

supports 'ubuntu', '14.04'
