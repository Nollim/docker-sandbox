FROM php:7.1-fpm

RUN apt-get update --fix-missing
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev

RUN docker-php-ext-install gd mbstring pdo pdo_mysql
