#
# Dockerfile for phalconphp/php:alpine-3-php7
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM webdevops/php:alpine-3-php7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# To override this run: docker run -e
ENV COMPOSER_HOME=/root/composer \
    PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1

# Add installers
ADD installers.tar /

RUN \
    # Update composer
    mkdir -p $COMPOSER_HOME \
    && /usr/local/bin/composer self-update \ 
    # Install dev environment
    && /usr/local/bin/apk-install --no-cache --virtual .dev-deps \
        autoconf \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        php7-dev \
    && ln -s /usr/bin/phpize7 /usr/bin/phpize \
    && ln -s /usr/bin/php-config7 /usr/bin/php-config \
    # Install extensions
    && /usr/local/bin/apk-install \
        php7-dba \
        php7-gmp \
        php7-imap \
        php7-odbc \
        php7-pdo_odbc \
        php7-pdo_pgsql \
        php7-pgsql \
        php7-pspell \
        php7-tidy \
        php7-xdebug \
    && sed -ri "s|;zend_extension|zend_extension|g" /etc/php7/conf.d/xdebug.ini \
    # Patch PHP 7
    && sed -ri "s|#( ?)(include <sys/poll.h>)|#\1include <poll.h>|g" /usr/include/php7/main/php_network.h \
    # Install phalcon
    && bash /installers/phalcon.sh \
    # Cleanup
    && apk del .dev-deps \
    && rm -rf \
        /installers \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/*
