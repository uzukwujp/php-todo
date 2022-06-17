FROM php:7.2-apache

USER root
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN echo "deb http://archive.ubuntu.com/ubuntu bionic main multiverse restricted universe" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu bionic-security main multiverse restricted universe" >> /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main multiverse restricted universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
    libpng-dev \
    zlib1g-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    zip \
    curl \
    unzip \
    && docker-php-ext-configure gd \
    && php7.2-mbstring \
    && php-ext-dom \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

COPY apache-config.conf  /etc/apache2/sites-available/000-default.conf
COPY ./ /var/www/html
COPY ./start-apache /usr/local/bin

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chown -R www-data:www-data /var/www/html \
    && a2enmod rewrite
CMD ["start-apache"]