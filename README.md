# app-php-fpm cookbook

A wrapper cookbook that installs PHP-FPM, Mariadb client, and Postfix on a node.

## Supported Platforms

Ubuntu >=14.04

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
    <td><tt>'5.6'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['exts']</tt></td>
    <td>Array</td>
    <td>PHP extensions to install. Extensions can also be installed manually using the resource `app_php_fpm_exts` as detailed below.</td>
    <td><tt>`['mysqlnd', 'cli', 'curl', 'zip']`</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['delete_pool_www']</tt></td>
    <td>Boolean</td>
    <td>Whether to delete the default pool named 'www'</td>
    <td><tt>true</tt></td>
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

### app_php_fpm_exts

Use in recipe to install PHP extensions:

```ruby
app_php_fpm_exts 'mcrypt'
```

```ruby
app_php_fpm_exts ['mysqlnd', 'cli', 'curl', 'zip']
```

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
