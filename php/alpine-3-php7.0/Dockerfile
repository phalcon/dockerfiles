#
# Dockerfile for phalconphp/php:alpine-3-php7
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM webdevops/php:alpine-php7

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

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
        php7-dev \
    # Install missed deps from EDGE
    && /usr/local/bin/apk-install libressl-dev --repository http://dl-4.alpinelinux.org/alpine/edge/main/ \
    && /usr/local/bin/apk-install gearman-dev --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ \
    # Create useful symlinks
    && ln -sf /usr/bin/phpize7 /usr/bin/phpize \
    && ln -sf /usr/bin/php-config7 /usr/bin/php-config \
    # Install dependencies
    && /usr/local/bin/apk-install \
        libsodium \
        libmemcached-dev \
        libtool \
        yaml-dev \
    # Install extensions
    && /usr/local/bin/apk-install \
        php7-amqp \
        php7-dba \
        php7-gmp \
        php7-imagick \
        php7-imap \
        php7-memcached \
        php7-odbc \
        php7-pdo_odbc \
        php7-pdo_pgsql \
        php7-pgsql \
        php7-pspell \
        php7-redis \
        php7-tidy \
        php7-xdebug \
    # Install tools
    && /usr/local/bin/apk-install \
        jq \
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
    && printf "\n" | pecl install -f mongodb-${MONGODB_DRIVER_VERSION} \
    && printf "\n" | pecl install -a msgpack \
    && printf "\n" | pecl install -a igbinary \
    && printf "\n" | pecl install -a ssh2-${SSH2_DRIVER_VERSION} \
    && printf "\n" | pecl install -a libsodium \
    && printf "\n" | pecl install -a yaml-${YAML_DRIVER_VERSION} \
    # Install apcu_bc
    && pecl config-set preferred_state beta \
    && printf "\n" | pecl install -a apcu_bc \
    # Install php nanotime support
    && bash /installers/nanotime.sh \
    # Install configs
    && mv /installers/etc/php7/conf.d/*.ini /etc/php7/conf.d/ \
    # Cleanup
    && apk del \
        .dev-deps \
    && rm -rf \
        /installers \
        /var/cache/apk/* \
        /tmp/* \
        /var/tmp/* \
    # Remove unneeded envirnment vars
    && unset MONGODB_DRIVER_VERSION SSH2_DRIVER_VERSION YAML_DRIVER_VERSION
