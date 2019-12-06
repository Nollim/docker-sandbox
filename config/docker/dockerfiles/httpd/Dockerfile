FROM httpd:2.4

# TODO switch to buster once https://github.com/docker-library/php/issues/865 is resolved in a clean way (either in the PHP image or in PHP itself)



WORKDIR /var/www/html

COPY config/docker/dockerfiles/httpd/000-default.conf /etc/apache2/sites-enabled/000-default.conf
COPY config/docker/dockerfiles/httpd/httpd.conf /usr/local/apache2/conf/httpd.conf