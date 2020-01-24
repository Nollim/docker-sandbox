FROM php:7.1-fpm

RUN apt-get update --fix-missing
RUN apt-get install -y zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev unzip git

RUN docker-php-ext-install gd mbstring pdo pdo_mysql zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug
RUN echo 'zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo 'xdebug.remote_port=9000' >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo 'xdebug.remote_enable=1' >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo 'xdebug.remote_connect_back=1' >> /usr/local/etc/php/conf.d/xdebug.ini

COPY config/docker/dockerfiles/php/memory-limit-php.ini /usr/local/etc/php/conf.d/memory-limit-php.ini