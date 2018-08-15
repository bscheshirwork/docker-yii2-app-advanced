
Install [docker](https://docs.docker.com/engine/getstarted/step_one/) and [docker-compose](https://docs.docker.com/compose/install/)
> Note: we need the latest version (read this instruction!) 

1.Clone project
```sh
$ git clone https://github.com/bscheshirwork/docker-yii2-advanced newproject
```

2.Start the `php` service

```sh
$ cd newproject/docker-run
$ docker-compose run php /bin/bash
Creating network "dockerrun_default" with the default driver
Creating dockerrun_db_1
root@abfe3b3ca645:/var/www/html#
```

Inside the container:
```sh
root@abfe3b3ca645:/var/www/html#
```
2.1.Run `composer update` and use github token (see `https://github.com/settings/tokens`)

cache folder simply linked into containers
`- ~/.composer/cache:/root/.composer/cache`

```sh
composer update -vv
```

2.2.Run yii2 init script (0 - Development) to create local settings (see [preparing-application](https://github.com/yiisoft/yii2-app-advanced/blob/master/docs/guide/start-installation.md#preparing-application) 1-3)
```sh
./init
``` 

2.3.Synchronize db settings (`docker-run/docker-compose.yml`, `php-code/common/config/main-local.php`; `docker-codeception-run/docker-compose.yml`, `php-code/common/config/test-local.php`)
`php-code/common/config/main-local.php`
```sh
'db' => [
    'class' => 'yii\db\Connection',
    'dsn' => 'mysql:host=db;dbname=yii2advanced',
    'username' => 'yii2advanced',
    'password' => 'yii2advanced',
    'charset' => 'utf8',
],
```

For tests we're using the same component `db` with the same connection string because we're using 
another folder to sync with docker contaner (`mysql-data-test`)
`php-code/common/config/test-local.php`
```sh
'db' => [
],
```

2.4.Run migration
```sh
./yii migrate
```
> Note: error? `docker-compose down` and `sudo rm -rf ../mysql-data/*` 

> Note: you can use mysqldump (in another terminal) this way:
```sh
docker exec dockerrun_db_1 sh -c 'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" yii2advanced' > /some/path/on/your/host/yii2advanced.sql
```

2.5.Leave container (`exit`, ctrl+c)

3.Run the composition
```sh
$ docker-compose up -d
Creating network "dockerrun_default" with the default driver
Creating dockerrun_db_1
Creating dockerrun_php_1
Creating dockerrun_nginx_1
```

4.See url `0.0.0.0:8080` - frontend, `0.0.0.0:8081` - backend

For xdebug we can use environment 
```yml
XDEBUG_CONFIG: "remote_host=dev-Aspire-V3-772 remote_port=9001"
PHP_IDE_CONFIG: "serverName=docker-yii2-advanced"
```
`remote_host` can be your IP address (outside of docker network) or your DNS if you have a dns-server (for example - local dns server or dns-server in your router; possibly you have a domain name like your machine name). Docker will connect to this DNS server from the running php container and resolve it.

> In `mac OS` you can use docker special name `host.docker.internal`.


PHPStorm settings:

Create new Service named <PHP_IDE_CONFIG value>
`Settings > Languages & Frameworks > PHP > Servers: [Name => yii2advanced]`
value is equal to `serverName` https://github.com/bscheshirwork/docker-yii2-app-advanced/blob/3cca9ab6521040fffd6fae4c6a8d485fde083b66/docker-run/docker-compose.yml#L14
(other values (`ip`, `port`) doesn't matter). 

Use path mapping:
`Settings > Languages & Frameworks > PHP > Servers: [Use path mapping => True, /your/machine/path/to/php-code => /var/www/html]`
Change debug port from 9000 to 9001
`Settings > Languages & Frameworks > PHP > Debug: [Debug port => 9001]`
https://github.com/bscheshirwork/docker-yii2-app-advanced/blob/3cca9ab6521040fffd6fae4c6a8d485fde083b66/docker-run/docker-compose.yml#L13
`remote_port=9001`
