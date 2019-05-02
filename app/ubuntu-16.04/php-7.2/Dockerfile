# Build image
FROM ubuntu:16.04 AS build-env

# install base packages, supervisor, cron, logrotate
RUN apt-get -y update \
    && apt-get install --no-install-recommends -yq \
       autoconf \
       build-essential \
       gcc \
       git \
       libjansson-dev \
       make \
       openssl \
       software-properties-common \
       unzip \
       wget \
       zlib1g-dev

ENV DEBIAN_FRONTEND=noninteractive \
    ZEPHIR_VERSION=0.11.12 \
    ZEPHIR_PARSER_VERSION=v1.3.1 \
    LIB_MAXMINDDB_VERSION=1.3.2 \
    NGINX_VERSION=1.16.0 \
    NGINX_USER=www-data \
    NGINX_CONF_PATH=/etc/nginx \
    NGINX_LOG_PATH=/var/log/nginx \
    NGINX_BUILD=Ubuntu \
    PCRE_VERSION=8.43 \
    PCRE_PATH=/var/lib/pcre \
    OPENSSL_VERSION=openssl-1.0.2o

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

COPY ./installers /installers

# build custom extensions and move it to /artifacts folder
RUN mkdir /artifacts \
    && bash /installers/zephir-parser.sh \
    && bash /installers/zephir.sh \
    && bash /installers/pinba.sh

# update openssl from openssl 1.0.2g to 1.0.2o
RUN bash /installers/openssl.sh

# configure NGINX from source
RUN bash /installers/nginx.sh
COPY ./configs/etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Application image
FROM phalconphp/base:ubuntu-16.04

LABEL description="Application image to use for production with PHP and Nginx" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.base.ubuntu-16.04"

ARG GITHUB_TOKEN
ARG GITHUB_USER
ARG PINBA_SERVER

ENV DEBIAN_FRONTEND=noninteractive \
    FPM_MAX_CHILDREN=32 \
    FPM_START_SERVERS=6 \
    FPM_MIN_SPARE_SERVERS=2 \
    FPM_MAX_SPARE_SERVERS=8 \
    FPM_PROCESS_IDLE_TIMEOUT=5 \
    FPM_MAX_REQUEST=1024 \
    PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_HOME=/root/composer \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PCRE_PATH=/var/lib/pcre \
    PINBA_SERVER=${PINBA_SERVER:-} \
    GITHUB_USER=${GITHUB_USER:-} \
    GITHUB_TOKEN=${GITHUB_TOKEN:-}

RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php

# Install php 7.1 with libs and other software
RUN apt-get update -y \
    && apt-get \
    -o Dpkg::Options::="--force-confdef" \
    -o Dpkg::Options::="--force-confold" \
    install -y -f --no-install-recommends \
      curl \
      dnsutils \
      git \
      iproute2 \
      jq \
      less \
      libc6-dev \
      libgeoip-dev \
      libpcre3-dev \
      libssh2-1-dev \
      libssl-dev \
      libyaml-dev \
      lsb-release \
      php-amqp \
      php-apcu-bc \
      php-igbinary \
      php-mcrypt \
      php-memcache \
      php-pear \
      php-sodium \
      php-ssh2 \
      php-xdebug \
      php-yaml \
      php7.2-bcmath \
      php7.2-cgi \
      php7.2-cli \
      php7.2-common \
      php7.2-curl \
      php7.2-dba \
      php7.2-dev \
      php7.2-fpm \
      php7.2-gd \
      php7.2-gmp \
      php7.2-imagick \
      php7.2-imap \
      php7.2-intl \
      php7.2-json \
      php7.2-mbstring \
      php7.2-memcached \
      php7.2-mongodb \
      php7.2-msgpack \
      php7.2-mysql \
      php7.2-odbc \
      php7.2-opcache \
      php7.2-pgsql \
      php7.2-phalcon \
      php7.2-pspell \
      php7.2-recode \
      php7.2-redis \
      php7.2-soap \
      php7.2-tidy \
      php7.2-xml \
      php7.2-zip \
      re2c \
      software-properties-common \
      swig \
      tmpreaper \
      tree \
      unzip \
      vim \
      wget

# Create required directories
RUN mkdir -p \
    /app \
    /tmp/xdebug-{profile,outpt} \
    /run/php \
    /var/log/php \
    /var/lib/nginx/{cache,proxy} \
    $COMPOSER_HOME

COPY --from=build-env /artifacts/ /
COPY ./configs/etc/php/7.2/ /etc/php/7.2/

RUN wget -qO- https://getcomposer.org/installer | \
       php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

# Disable following modules by default
RUN phpdismod -v 7.2 apcu_bc \
    && phpdismod -v 7.2 apcu \
    && phpdismod -v 7.2 mongodb \
    && phpdismod -v 7.2 pinba \
    && phpdismod -v 7.2 xdebug

# Nginx with GeoIP setup
RUN apt-get install -y \
    libjansson-dev \
    libmaxminddb0 \
    mmdb-bin \
    nginx \
    openssl \
    zlib1g-dev

RUN mkdir -p /usr/share/GeoIP \
    && wget -qO - \
      http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz \
      | gunzip -c > /usr/share/GeoIP/maxmind-city.mmdb \
    && wget -qO - \
      http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz \
      | gunzip -c > /usr/share/GeoIP/maxmind-country.mmdb

COPY --from=build-env $PCRE_PATH $PCRE_PATH
COPY --from=build-env /usr/sbin/nginx /usr/sbin/nginx
COPY ./configs/etc/nginx/ /etc/nginx/

# Supervisor && logrotate
COPY ./configs/etc/supervisor/ /etc/supervisor/
COPY ./configs/etc/logrotate.d/ /etc/logrotate.d/

# Startup scripts
COPY ./entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d /entrypoint.d

# Final check and preparing entrypoint
RUN echo \
    && nginx -v \
    && composer --version --no-ansi \
    && zephir --version \
    && php -r 'echo "Phalcon " . \Phalcon\Version::get() . "\n";' \
    && echo -n "Zephir Parser " && php \
      -d extension=`php-config --extension-dir`/zephir_parser.so \
      --ri "Zephir Parser" | grep Version | awk '{print $3}' \
    && echo \
    && chmod +x /entrypoint.sh

# Cleanup
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists \
       -not -name lock \
       -type f \
       -delete \
    && find /var/cache -type f -not -name lock -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

VOLUME /app \
       /var/log/nginx \
       /var/log/php \
       /tmp/xdebug-profile \
       /tmp/xdebug-outupt \
       /var/lib/nginx/cache \
       /var/lib/nginx/proxy

WORKDIR /app

# Local Variables:
# tab-width: 4
# End:
