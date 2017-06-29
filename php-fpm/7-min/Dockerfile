#
# PHP-CLI 7 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM php:7.0-fpm

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN curl -O https://codeload.github.com/phalcon/cphalcon/tar.gz/v3.2.0
RUN tar xvzf v3.2.0
RUN cd cphalcon-3.2.0/build && ./install
RUN cd ../../ && rm -Rf cphalcon-3.2.0 && rm -Rf v3.2.0
RUN echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini

RUN apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php5 /etc/php/5* /usr/lib/php/20121212 /usr/lib/php/20131226

RUN rm -rf /var/log /var/cache
