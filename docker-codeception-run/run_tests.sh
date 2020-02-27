#!/bin/bash
cd /var/www/html
ls -luha
./yii migrate/up --interactive=0
cd frontend
codecept run 
