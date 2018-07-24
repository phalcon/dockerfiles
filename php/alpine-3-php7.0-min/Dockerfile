#
# Dockerfile for phalconphp/php:alpine-php7-min
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM php:7.0-alpine

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN \
    # Install dev dependencies
    apk --update add --virtual build-dependencies \
        autoconf \
        g++ \
        file \
        re2c \
        make \
        git \
    # Install latest Phalcon
    && git clone --depth 1 https://github.com/phalcon/cphalcon.git /tmp/phalcon \
    && cd /tmp/phalcon/build \
    && sh install \
    && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/50-phalcon.ini \
    # Cleanup
    && apk del build-dependencies \
    && rm -rf \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/*