#
# Dockerfile for phalconphp/php:alpine-3-php7
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM php:7.0-alpine

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN apk update && apk add \
        autoconf \
        g++ \
        make && curl -O https://codeload.github.com/phalcon/cphalcon/tar.gz/v3.0.4 && \
        tar xvzf v3.0.4 && \
        cd cphalcon-3.0.4/build && sh install && \
        cd ../../ && rm -Rf cphalcon-3.0.4 && rm -Rf v3.0.4 && \
        echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini \
    && rm -rf \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/* \
    && apk del autoconf g++ make
