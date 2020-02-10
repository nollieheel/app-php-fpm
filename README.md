# app-php-fpm cookbook

A cookbook that installs Composer, PHP-FPM, and Mariadb client. Running this cookbook creates just one PHP-FPM pool which can be configured using node attributes.

Note: This cookbook has been rewritten because of this issue: https://github.com/oerdnj/deb.sury.org/issues/1334 where the package apparently started adding ExecStartPost and ExecStopPost directives in the php-fpm unit.

## Supported Platforms

Ubuntu >=16.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['version']</tt></td>
    <td>String</td>
    <td>Version of PHP-FPM to install.</td>
    <td><tt>'7.3'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['package_ver']</tt></td>
    <td>String</td>
    <td>Specific version of the apt package to install (Optional).</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['conf']</tt></td>
    <td>Hash</td>
    <td>Contains most of the property values for the file php-fpm.conf. Reasonable defaults have been set. See the attributes file.</td>
    <td><tt>See attribute file</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['pool']</tt></td>
    <td>Hash</td>
    <td>Contains most of the property values for the php-fpm pool. Only the pool 'name' property is mandatory here. The rest have been set to reasonable defaults.</td>
    <td><tt>See attribute file</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['exts']</tt></td>
    <td>Array</td>
    <td>PHP extensions to install. Extensions can also be installed manually using the resource `php_ext` as detailed below.</td>
    <td><tt>`['mysqlnd', 'cli', 'curl', 'zip']`</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['mariadb']['version']</tt></td>
    <td>String</td>
    <td>Version of MariaDB client to install.</td>
    <td><tt>'10.4'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['mariadb']['repo']</tt></td>
    <td>String</td>
    <td>MariaDB repository [location](https://downloads.mariadb.org/mariadb/repositories/#mirror=utm).</td>
    <td><tt>'http://nyc2.mirrors.digitalocean.com/mariadb/repo'</tt></td>
  </tr>
</table>

## Usage

### app-php-fpm::default

Include `app-php-fpm` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[app-php-fpm::default]"
  ]
}
```

## Resources

### php_ext

Use in recipe to install PHP extensions:

```ruby
php_ext 'mbstring'
```

```ruby
php_ext ['mysqlnd', 'cli', 'curl', 'zip']
```

## License and Authors

Author:: Earth U (<iskitingbords@gmail.com>)
