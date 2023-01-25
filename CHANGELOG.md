# app_php_fpm CHANGELOG

## 5.1.0 - 2023-01-26
### Removed
- Unnecessary attribute file

### Added
- Verified support for Ubuntu 22.04

## 5.0.0 - 2022-06-29
- Bunch of BREAKING changes
- Renamed cookbook to `app_php_fpm`
- Reworked cookbook into a resource-based approach
- Supports only Ubuntu 20.04

## 4.0.0 - 2020-02-14
## Removed
- Dependency on cookbook-php-fpm.
- Dependency on composer.
- Support for Ubuntu 14.04.

## Changed
- Rewritten for systemd on Ubuntu >= 16.04 only.
- PHP-FPM and composer are now installed by this cookbook, not another dependent one.
- Updated config as approriate for PHP >= 7.x.
- Renamed resource app_php_fpm_exts to just php_ext and modified the property names.
- Updated tests.

## 3.0.0 - 2020-01-19
## Removed
- Dependency and installation on postfix.
- RHEL-related code.

## Changed
- Bumped mariadb cookbook version to latest.

## Added
- Inspec tests.

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
