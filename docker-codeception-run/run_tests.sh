#!/bin/bash
echo "composer global show"
composer global show
cd /repo
echo "codeception: composer show"
composer show
cd /var/www/html
echo "testing code: composer show"
composer show
ls -luha
./yii migrate/up --interactive=0
codecept run --no-redirect
