#!/bin/bash

composer install --no-progress --no-interaction
php artisan migrate 
php artisan key:generate 
php artisan serve  --port=$PORT --host=0.0.0.0 --env=.env 
exec docker.php.entrypoint  "$@"


