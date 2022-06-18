#!/usr/bin/env bash
sed -i "s/Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf
sed -i "s/:80/:${PORT:-80}/g" /etc/apache2/sites-enabled/*
apache2-foreground

composer install
php artisan migrate
php artisan key:generate
php artisan serve --host 0.0.0.0

exec docker-php-entrypoint "$@"
