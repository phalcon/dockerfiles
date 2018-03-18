FROM ubuntu:16.04 AS build-env

ENV DEBIAN_FRONTEND=noninteractive \
    ZEPHIRDIR=/usr/share/zephir \
    ZEPHIR_VERSION=0.10.7 \
    ZEPHIR_PARSER_VERSION=v1.1.2 \
    GOREPLACE_VERSION=1.1.2 \
    SETUP_DIR=/installers \
    NGINX_VERSION=1.11.9 \
    NGINX_USER=www-data \
    NGINX_CONF_PATH=/etc/nginx \
    NGINX_LOG_PATH=/var/log/nginx \
    NGINX_BUILD=Ubuntu \
    PCRE_VERSION=8.41 \
    PCRE_PATH=/opt/prce

RUN apt-get -y update \
    && apt-get install -y \
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
        unzip \
        vim \
        zlib1g-dev

RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt-get update -y

RUN apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y -f --no-install-recommends \
    re2c \
    libc6-dev \
    libpcre3-dev \
    libssh2-1-dev \
    libssl-dev \
    libyaml-dev \
    libgeoip-dev \
    lsb-release \
    php7.1-dev \
    php7.1-common \
    php7.1-cli \
    php7.1-xml

RUN curl -sSL https://github.com/webdevops/go-replace/releases/download/$GOREPLACE_VERSION/gr-64-linux -o /usr/local/bin/go-replace \
    && chmod +x /usr/local/bin/go-replace

COPY ./installers $SETUP_DIR

RUN mkdir /artifacts \
    && bash $SETUP_DIR/zephir-parser.sh \
    && bash $SETUP_DIR/zephir.sh \
    && bash $SETUP_DIR/aerospike.sh \
    && bash $SETUP_DIR/pinba.sh \
    && bash $SETUP_DIR/nginx.sh

COPY configs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
RUN /usr/local/bin/go-replace -s '%NGINX_LOG_PATH%' -r "${NGINX_LOG_PATH}" /etc/nginx/nginx.conf

# ------------------------------------------------------------

FROM phalconphp/base:ubuntu-16.04

ENV COMPOSER_HOME=/root/composer \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PATH=/root/composer/vendor/bin:$PATH \
    FPM_MAX_CHILDREN=32 \
    FPM_START_SERVERS=6 \
    FPM_MIN_SPARE_SERVERS=2 \
    FPM_MAX_SPARE_SERVERS=8 \
    FPM_PROCESS_IDLE_TIMEOUT=5 \
    FPM_MAX_REQUEST=1024 \
    NGINX_LOG_PATH=/var/log/nginx

LABEL description="Slimmed-down image to use for production with PHP, Supervisord, Cron and Nginx" \
    name=php7.1-ubuntu16

RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt-get update -y \
    && apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y -f --no-install-recommends \
        dnsutils \
        iproute2 \
        libc6-dev \
        libgeoip-dev \
        libjansson-dev \
        libpcre3-dev \
        libssh2-1-dev \
        libssl-dev \
        libyaml-dev \
        nginx \
        openssl \
        php-amqp \
        php-apcu-bc \
        php-igbinary \
        php-memcache \
        php-pear \
        php-sodium \
        php-ssh2 \
        php-xdebug \
        php-yaml \
        php7.1-bcmath \
        php7.1-cgi \
        php7.1-cli \
        php7.1-common \
        php7.1-curl \
        php7.1-dba \
        php7.1-dev \
        php7.1-fpm \
        php7.1-gd \
        php7.1-gmp \
        php7.1-imagick \
        php7.1-imap \
        php7.1-intl \
        php7.1-json \
        php7.1-mbstring \
        php7.1-mcrypt \
        php7.1-memcached \
        php7.1-mongodb \
        php7.1-msgpack \
        php7.1-mysql \
        php7.1-odbc \
        php7.1-opcache \
        php7.1-pgsql \
        php7.1-phalcon \
        php7.1-pspell \
        php7.1-recode \
        php7.1-redis \
        php7.1-soap \
        php7.1-tidy \
        php7.1-xml \
        php7.1-zip \
        zlib1g-dev

RUN mkdir -p \
        /app \
        /run/php \
        /var/log/php \
        /opt/geoip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    && composer --version --no-ansi \
    && rm -rf /etc/nginx \
    && git clone --depth=1 -q https://github.com/h5bp/server-configs-nginx /etc/nginx \
    && mkdir -p /etc/nginx/conf.d $NGINX_LOG_PATH

COPY --from=build-env /opt/prce /opt/prce
COPY --from=build-env /usr/sbin/nginx /usr/sbin/nginx
COPY --from=build-env /artifacts /artifacts
COPY configs /

RUN mv /artifacts/aerospike /usr/local/ \
    && mv /artifacts/aerospike.so "$(php-config --extension-dir)/aerospike.so" \
    && mv /artifacts/pinba.so "$(php-config --extension-dir)/pinba.so" \
    && tar xf /opt/geoip/GeoLite.tar.gz -C /opt/geoip \
    && phpenmod -v 7.1 aerospike || true \
    && phpdismod -v 7.1 pinba || true \
    && phpdismod -v 7.1 xdebug || true \
    && /usr/local/bin/go-replace -s '%NGINX_LOG_PATH%' -r "${NGINX_LOG_PATH}" /etc/nginx/nginx.conf \
    && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default \
    && pecl channel-update pecl.php.net

ARG BUILD_ID=0
ARG VERSION=0.0.1

ENV BUILD_ID=${BUILD_ID} \
    VERSION=${VERSION}

LABEL build_id="${BUILD_ID}" \
    version="${VERSION}"

WORKDIR /app

COPY ./entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d /entrypoint.d
RUN chmod +x /entrypoint.sh

RUN apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf \
        /tmp/* \
        /var/tmp/* \
        /artifacts \
        /opt/geoip/GeoLite.tar.gz \
    && find /var/log -type f | while read f; do echo -ne '' > ${f} >/dev/null 2>&1 || true; done \
    && mkdir -p \
        /tmp/nginx/proxy \
        /tmp/nginx/cache \
        /tmp/debug

EXPOSE 80 443 9000
VOLUME ["/var/log/nginx", "/tmp/nginx", "/tmp/debug"]

ENTRYPOINT ["/entrypoint.sh"]
