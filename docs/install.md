
Install [docker](https://docs.docker.com/engine/getstarted/step_one/) and [docker-compose](https://docs.docker.com/compose/install/)
> Note: we need latest version (read instruction!) 

1.Clone project
```
$ git clone https://github.com/bscheshirwork/docker-yii2-advanced newproject
```

2.Start the `php` service

```
$ cd newproject/docker-run
$ docker-compose run php /bin/bash
Creating network "dockerrun_default" with the default driver
Creating dockerrun_db_1
root@abfe3b3ca645:/var/www/html#
```

Inside container:
```
root@abfe3b3ca645:/var/www/html#
```
2.1.Run `composer update` use github token (see `https://github.com/settings/tokens`)

```
composer update
```

2.2.Run yii2 init script (0 - Development) for create local settings (see [preparing-application](https://github.com/yiisoft/yii2-app-advanced/blob/master/docs/guide/start-installation.md#preparing-application) 1-3)
```
./init
``` 

2.3.Synchronize db settings (`docker-run/docker-compose.yml`, `php-code/common/config/main-local.php`; `docker-codeception-run/docker-compose.yml`, `php-code/common/config/test-local.php`)
`php-code/common/config/main-local.php`
```
'db' => [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=db;dbname=yii2advanced',
    'username' => 'yii2advanced',
    'password' => 'yii2advanced',
    'charset' => 'utf8',
],
```

For test used another base, but the same named service `db` (and the same connect string)
`php-code/common/config/test-local.php`
```
'db' => [
],
```

2.4.Run migration
```
./yii migrate
```
> Note: error? `docker-compose down` and `sudo rm -rf ../mysql-data/*` 


2.4.Leave container (`exit`, ctrl+c)

3.Run the composition
```
$ docker-compose up -d
Creating network "dockerrun_default" with the default driver
Creating dockerrun_db_1
Creating dockerrun_php_1
Creating dockerrun_nginx_1
```

4.See url `0.0.0.0:8080` - frontend, `0.0.0.0:8081` - backend

For xdebug use environment (for example your ip is 192.168.0.83)
```
XDEBUG_CONFIG: "remote_host=192.168.0.83 remote_port=9001"
PHP_IDE_CONFIG: "serverName=docker-yii2-advanced"
```
PHPStorm settings:

Create new Service named (like PHP_IDE_CONFIG value)
`Settings > Languages & Frameworks > PHP > Servers: [Name => docker-yii2-advanced]`
Use path mapping:
`Settings > Languages & Frameworks > PHP > Servers: [Use path mapping => True, /home/user/petshelter/php-code => /var/www/html]`
Change debug port 9000
`Settings > Languages & Frameworks > PHP > Debug: [Debug port => 9001]`