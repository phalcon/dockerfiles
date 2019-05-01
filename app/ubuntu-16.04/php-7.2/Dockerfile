# docker build -t phalconphp/ubuntu-16.04:php-7.2 .

# Build image
FROM ubuntu:16.04 AS build-env

# install base packages, supervisor, cron, logrotate
RUN apt-get -y update \
    && apt-get install --no-install-recommends -yq \
       autoconf \
       build-essential \
       curl \
       gcc \
       git \
       less \
       libjansson-dev \
       make \
       openssl \
       software-properties-common \
       tree \
       unzip \
       vim \
       wget \
       zlib1g-dev

ARG GITHUB_TOKEN
ARG GITHUB_USER

ENV DEBIAN_FRONTEND="noninteractive" \
    PINBA_SERVER=127.0.0.1 \
    PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_HOME=/root/composer \
    COMPOSER_ALLOW_SUPERUSER=1 \
    FPM_MAX_CHILDREN=32 \
    FPM_START_SERVERS=6 \
    FPM_MIN_SPARE_SERVERS=2 \
    FPM_MAX_SPARE_SERVERS=8 \
    FPM_PROCESS_IDLE_TIMEOUT=5 \
    FPM_MAX_REQUEST=1024 \
    ZEPHIR_VERSION="0.11.12" \
    ZEPHIR_PARSER_VERSION="v1.3.0" \
    GITHUB_USER=${GITHUB_USER:-cicdbot} \
    GITHUB_TOKEN=${GITHUB_TOKEN:-""} \
    NGINX_VERSION=1.14.2 \
    NGINX_USER=www-data \
    NGINX_CONF_PATH=/etc/nginx \
    NGINX_LOG_PATH=/var/log/nginx \
    NGINX_BUILD=Ubuntu \
    PCRE_VERSION=8.43 \
    PCRE_PATH=/opt/prce \
    OPENSSL_VERSION="openssl-1.0.2o"

RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt-get update -y

# PHP 7.2 with dependencies
RUN apt-get \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    install -y -f --no-install-recommends \
        jq \
        libc6-dev \
        libexpat-dev \
        libgeoip-dev \
        libpcre3-dev \
        libssh2-1-dev \
        libssl-dev \
        libxslt1-dev \
        libyaml-dev \
        lsb-release \
        php7.2-cli \
        php7.2-common \
        php7.2-dev \
        php7.2-xml \
        re2c

# Nginx dependencies
RUN apt-get \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    install -y -f --no-install-recommends \
        libexpat-dev \
        libmaxminddb-dev \
        mmdb-bin \
        libmaxminddb0

# turn the detached message off
RUN git config --global advice.detachedHead false

# install latest composer
RUN export COMPOSER_HOME=$COMPOSER_HOME \
    && export PATH=$PATH \
    && export COMPOSER_ALLOW_SUPERUSER=$COMPOSER_ALLOW_SUPERUSER \
    && mkdir $COMPOSER_HOME \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    && composer --version --no-ansi

COPY ./installers /installers

# build custom extensions and move it to /artifacts folder
RUN find /installers -type f -regex ".+sh" | xargs chmod +x \
    && mkdir /artifacts \
    && bash /installers/zephir-parser.sh \
    && bash /installers/zephir.sh

RUN tree /artifacts

# Application image
FROM phalconphp/base:ubuntu-16.04

# Local Variables:
# tab-width: 4
# End:
