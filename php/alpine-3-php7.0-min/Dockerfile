#
# Dockerfile for phalconphp/php:alpine-php7-min
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM php:7.0-alpine

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV PHALCON_VERSION=3.2.1

RUN \
    # Install dev dependencies
    apk --update add --virtual build-dependencies \
        autoconf \
        g++ \
        file \
        re2c \
        make \
    # Install latest Phalcon
    && curl -sS -o /tmp/phalcon.tar.gz https://codeload.github.com/phalcon/cphalcon/tar.gz/v$PHALCON_VERSION \
    && cd /tmp/ \
    && tar xvzf phalcon.tar.gz \
    && cd cphalcon-$PHALCON_VERSION/build \
    && sh install \
    && echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/50-phalcon.ini \
    # Cleanup
    && apk del build-dependencies \
    && rm -rf cphalcon-$PHALCON_VERSION \
        v3.2.1 \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/* \
    # Remove unneeded envirnment vars
    && unset PHALCON_VERSION