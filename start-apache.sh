#!/bin/bash

composer install --no-progress --no-interaction
php artisan migrate 
php artisan key:generate 
php artisan serve --post=8000 --host=0.0.0.0  



