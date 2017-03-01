#
# Dockerfile for phalconphp/php:alpine-3-php7
#
# https://github.com/phalcon/dockerfiles
#

FROM webdevops/php:alpine-3-php7

# Pull base image
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
    # Install phalcon
    && bash /installers/phalcon.sh \
    # Cleanup
    && apk del .dev-deps \
    && rm -rf \
        /installers \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/*
