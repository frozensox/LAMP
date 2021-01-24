#!/bin/bash

error_log() {
  echo ''
  echo $1
  exit 1
}

(docker-compose up -d --build || error_log 'Failed to build container.') &&
(docker-compose exec web composer create-project --prefer-dist laravel/laravel . || error_log 'Failed to install Laravel.') &&
(docker-compose exec web php artisan migrate || error_log 'Failed to migrate in Laravel.') &&
echo '' &&
echo 'Installation was successful.'
