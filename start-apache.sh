#!/bin/bash

composer install --no-progress --no-interaction
php artisan migrate 
php artisan key:generate 
php artisan serve --port=80 --host=0.0.0.0  



