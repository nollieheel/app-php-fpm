# app_php_fpm cookbook
A cookbook that installs PHP-FPM, extensions, and Composer.
## Supported Platforms
Ubuntu 22.04, 24.04
## Usage
This cookbook supplies only resources for other cookbooks to use. There are no recipes. Check the [resources dir](resources/) for more details on the resources themselves.
### php_package
Install PHP-FPM version `7.4`, `8.0`, `8.1`, `8.2`, or `8.3` only:
```ruby
php_package '8.1' do
  pool_name 'myapp'
  pool_user 'www-data'
end
```
### php_ext
Install PHP extension/s:
```ruby
php_ext 'mbstring' do
  php_version '8.1'
end
```

```ruby
php_ext ['mysql', 'curl', 'zip'] do
  php_version '8.1'
end
```
### php_composer
Install the `composer` binary in `/usr/local/bin` (by default):
```ruby
php_composer '2.3.7'
```
## License and Authors
Author:: Earth U (<iskitingbords@gmail.com>)
