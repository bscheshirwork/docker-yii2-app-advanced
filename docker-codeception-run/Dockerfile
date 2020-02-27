FROM bscheshir/codeception:php7.4.2-fpm-alpine-yii2

COPY ./run_tests.sh /run_tests.sh
RUN git clone https://github.com/yiisoft/yii2-app-advanced.git /var/www/html
RUN composer install
RUN ./init --env=Development --overwrite=All
RUN ./yii migrate/up --interactive=0
