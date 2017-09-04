name             'app-php-fpm'
maintainer       'Earth U'
maintainer_email 'iskitingbords @ gmail.com'
license          'Apache License'
description      'Just a wrapper for setting up PHP-FPM-based apps'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/nollieheel/app-php-fpm'
issues_url       'https://github.com/nollieheel/app-php-fpm/issues'
version          '0.1.2'

depends 'php-fpm', '~> 0.7.5'
depends 'mariadb', '~> 0.3.1'
depends 'postfix', '~> 3.6.2'

supports 'ubuntu', '14.04'
