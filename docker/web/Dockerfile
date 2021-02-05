# node.js
# FROM node:14-buster as node

# PHP 7.4 apache
FROM php:7.4-apache

# shell
SHELL ["/bin/bash", "-ouex", "pipefail", "-c"]

# environment
ENV COMPOSER_ALLOW_SUPERUSER=1 \
  COMPOSER_HOME=/composer

# composer command
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer
# node command
# COPY --from=node /usr/local/bin /usr/local/bin
# npm command
# COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
# COPY --from=node /opt /opt

# need for install Laravel
RUN apt-get update && \
  apt-get -y install git unzip libzip-dev libicu-dev libonig-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  docker-php-ext-install intl pdo_mysql zip bcmath && \
  a2enmod rewrite
