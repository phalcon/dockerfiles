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
    COMPOSER_ALLOW_SUPERUSER=1 \
    SSH2_DRIVER_VERSION=1.0 \
    YAML_DRIVER_VERSION=2.0.0 \
    # https://github.com/mongodb/mongo-php-driver/issues/507 (Not compile with latest)
    MONGODB_DRIVER_VERSION=1.1.10

# Add installers
ADD installers.tar /

RUN \
    # Update composer
    mkdir -p $COMPOSER_HOME \
    && /usr/local/bin/composer self-update \ 
    # Install dev environment
    && /usr/local/bin/apk-install --no-cache --virtual .dev-deps \
        autoconf \
        automake \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        libtool \
        check \
        check-dev \
        cyrus-sasl-dev \
        libsodium-dev \
        libssh2-dev \
        imagemagick-dev \
        yaml-dev \
        php7-dev \
    # Install missed deps from EDGE
    && /usr/local/bin/apk-install gearman-dev --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    # Create useful symlinks
    && ln -s /usr/bin/phpize7 /usr/bin/phpize \
    && ln -s /usr/bin/php-config7 /usr/bin/php-config \
    # Install dependencies
    && /usr/local/bin/apk-install \
        libsodium \
        libmemcached-dev \
        libtool \
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
    # Install pinba
    && bash /installers/pinba.sh \
    # Install gearman
    && bash /installers/gearman.sh \
    # Install handlersoketi
    && bash /installers/handlersocketi.sh \
    # Patch PECL
    && sed -i "$ s|\-n||g" /usr/bin/pecl \
    && pecl channel-update pecl.php.net \
    # Install PECL extensions
    && printf "\n" | pecl install -a imagick \
    && echo "extension=imagick.so" > /etc/php7/conf.d/20-imagick.ini \
    && printf "\n" | pecl install -a memcached \
    && echo "extension=memcached.so" > /etc/php7/conf.d/20-memcached.ini \
    && printf "\n" | pecl install -f mongodb-${MONGODB_DRIVER_VERSION} \
    && echo "extension=mongodb.so" > /etc/php7/conf.d/20-mongodb.ini \
    && printf "\n" | pecl install -a msgpack \
    && echo "extension=msgpack.so" > /etc/php7/conf.d/20-msgpack.ini \
    && printf "\n" | pecl install -a igbinary \
    && echo "extension=igbinary.so" > /etc/php7/conf.d/20-igbinary.ini \
    && printf "\n" | pecl install -a redis \
    && echo "extension=redis.so" > /etc/php7/conf.d/20-redis.ini \
    && printf "\n" | pecl install -a ssh2-${SSH2_DRIVER_VERSION} \
    && echo "extension=ssh2.so" > /etc/php7/conf.d/20-ssh2.ini \
    && printf "\n" | pecl install -a libsodium \
    && echo "extension=libsodium.so" > /etc/php7/conf.d/20-libsodium.ini \
    && printf "\n" | pecl install -a yaml-${YAML_DRIVER_VERSION} \
    && echo "extension=yaml.so" > /etc/php7/conf.d/20-yaml.ini \
    # Install apcu_bc
    && pecl config-set preferred_state beta \
    && printf "\n" | pecl install -a apcu_bc \
    # See See https://pear.php.net/bugs/bug.php?id=21007
    && echo "[APCu]" > /etc/php7/conf.d/apcu.ini \
    && echo "extension=apcu.so" >> /etc/php7/conf.d/apcu.ini \
    && echo "[APC]" >> /etc/php7/conf.d/apcu.ini \
    && echo "extension=apc.so" >> /etc/php7/conf.d/apcu.ini \
    && echo "apc.enabled=1" >> /etc/php7/conf.d/apcu.ini \
    && echo "apc.enable_cli=1" >> /etc/php7/conf.d/apcu.ini \
    # Install php nanotime support
    && bash /installers/nanotime.sh \
    # Cleanup
    && apk del \
        .dev-deps \
    && rm -rf \
        /installers \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/*
