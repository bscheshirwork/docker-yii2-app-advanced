FROM bscheshir/codeception:php7.4.3-fpm-alpine-yii2

COPY ./run_tests.sh /run_tests.sh
RUN /bin/bash -c 'chmod +x /run_tests.sh'
RUN cat /run_tests.sh
RUN ls -luha /run_tests.sh
RUN curl -L https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -o /usr/local/bin/wait-for-it.sh
RUN /bin/bash -c 'chmod +x /usr/local/bin/wait-for-it.sh'
RUN ls -luha /usr/local/bin/wait-for-it.sh
ENTRYPOINT ["/usr/local/bin/wait-for-it.sh", "db:3306", "--", "/run_tests.sh"]
RUN git clone https://github.com/yiisoft/yii2-app-advanced.git /var/www/html
RUN composer install --no-dev
RUN ./init --env=Development --overwrite=All
