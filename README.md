Dockerized docker-yii2-advanced
===============================

Docker image composition (docker-compose) for [yii2-app-advanced](https://github.com/yiisoft/yii2-app-advanced):

Simplify your way to start with pure yii2-app-advanced template.
 
Use `docker-compose up -d` for run without any debug tools. We can use `nginx-proxy` in same `docker network`.
 
You can also use `./docker-compose.yml` (`docker-compose up -d`) in production.
 
Create your own local config `cp .env_example .env` and...
 
Use `docker-compose -f docker-codeception-run/docker-compose.yml up -d` for built-in image `Codeception`'s tests 

Use `docker-compose -f docker-run/docker-compose.yml up -d` for debug you project through `XDebug`; `mysql-proxy` for show sql-query log.

* [Install](./docs/install.md)
* [Codeception](/docs/codeception.md).
* [mysql-proxy](/docs/mysql-proxy.md).
* [nginx-proxy](/docs/nginx-proxy.md).

All Rights Reserved.

2018 © bscheshir.work@gmail.com
