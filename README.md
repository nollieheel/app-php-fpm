# app-php-fpm cookbook

A wrapper cookbook that installs PHP-FPM, mariadb client, and postfix on a node.

## Supported Platforms

Ubuntu 14.04

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
    <td>Version of PHP-FPM to install. Either '5.5' or '5.6'.</td>
    <td><tt>'5.6'</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['delete_pool_www']</tt></td>
    <td>Boolean</td>
    <td>Whether to delete the default pool named 'www'</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['exts']</tt></td>
    <td>Array</td>
    <td>PHP modules to install. Array of module names without the 'php5-' prefixes.</td>
    <td><tt>['mysqlnd', 'cli', 'curl', 'zip']</tt></td>
  </tr>
  <tr>
    <td><tt>['app-php-fpm']['postfix']['update_cacert']</tt></td>
    <td>Boolean</td>
    <td>Whether to get the latest cacert from https://curl.haxx.se/ca/cacert.pem for postfix use.</td>
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

## License and Authors

Author:: Earth U (<iskitingbords @ gmail.com>)
