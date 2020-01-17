FROM php:7.1-fpm

RUN apt-get update --fix-missing
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev unzip git

RUN docker-php-ext-install gd mbstring pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
