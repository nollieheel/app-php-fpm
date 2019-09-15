## 2.1.0 - 2019-09-13
### Added
- Default recipe now installs Composer.

### Removed
- Attribute `exts_rhel_only` now defaults to empty array. It used to contain `xml` and `mbstring`, but now it looks like those are installable in Ubuntu 16.04 as well.

## 2.0.0 - 2019-09-10
### Changed
- Bump dependent versions.
- Optimized the resource `app_php_fpm_exts` resource by adding support for other PHP versions and node platforms.
- Included auto-installing PHP extensions in the default recipe.

### Added
- Support for Ubuntu 16.04
- Support for PHP 7.x

### Removed
- Support for Chef 13 and below.

## 1.0.0 - 2018-05-04
### Changed
- Now depends on php-fpm cookbook v0.8.0.
- Remove support for EOL Ubuntu.

## 0.2.0 - 2018-04-28
### Removed
- Removed recipe php-fpm_exts.
- Removed recipes mariadb_client and postfix. Replaced those with
include_recipe calls to respective wrapped cookbooks.

### Added
- New custom resource app_php_fpm_exts for installing PHP extensions.
- Correct repo sources for MariaDB packages.

### Changed
- Bumped versions of dependency cookbooks.
- Minor adjustments to default attribute values.
- Added some commented-out attributes in attributes file just for reference.

## 0.1.2 - 2017-09-05
### Fixed
- Updated metadata version number.

## 0.1.1 - 2017-08-23
### Fixed
- Remove openssl dependency. Openssl itself is not needed here.

## 0.1.0 - 2017-08-23
### Added
- Initial working version of the cookbook

---
Changelog format reference: http://keepachangelog.com/en/0.3.0/
