#!/bin/bash
cd /var/www/html
ls -luha
#todo: use wait-fot-it
#./yii migrate/up --interactive=0
cd frontend
codecept run 
