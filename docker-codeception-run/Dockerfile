FROM bscheshir/php:7.1.3-fpm-4yii2-xdebug
# -t bscheshir/codeception:php7.1.3-fpm-4yii2aar .
MAINTAINER BSCheshir <bscheshir.work@gmail.com>

# Install required system packages
RUN apt-get update && \
    apt-get -y install \
            zlib1g-dev \
            libssl-dev \
        --no-install-recommends && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install php extensions
RUN docker-php-ext-install \
    bcmath

# Configure php
RUN echo "date.timezone = UTC" >> /usr/local/etc/php/php.ini

# Prepare application
WORKDIR /repo

# Install vendor
COPY ./composer.json /repo/composer.json

# Install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer global require --optimize-autoloader \
        "hirak/prestissimo" && \
  composer install --prefer-dist --optimize-autoloader

# Add source-code
COPY . /repo

ENV PATH /repo:${PATH}
ENTRYPOINT ["codecept"]

# Prepare host-volume working directory
RUN mkdir /project
WORKDIR /project