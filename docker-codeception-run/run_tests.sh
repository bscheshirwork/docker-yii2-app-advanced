#!/bin/bash
cd /var/www/html
composer show
composer global show
composer require codeception/module-filesystem codeception/module-yii2 --dev
ls -luha
#todo: use wait-fot-it
#./yii migrate/up --interactive=0
cd frontend
codecept run --no-redirect unit
