FROM php:7.2-apache

RUN docker-php-ext-install mysqli
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data ./start-apache
COPY ./start-apache /usr/local/bin
RUN a2enmod rewrite

# Copy application source
COPY ./ /var/www
RUN chown -R www-data:www-data /var/www

CMD ["start-apache"]
