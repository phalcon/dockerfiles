#
# Dockerfile for phalconphp/php:7.1-dev
#
# https://github.com/phalcon/dockerfiles
#
# Run it as:
# docker run -it --rm --privileged=true phalconphp/php:7.1-dev bash
#

# Pull base image
FROM debian:jessie

# Add installers
ADD base.tar /

# Set environment variables
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    PHP_CPPFLAGS="$PHP_CFLAGS" \
    PHP_LDFLAGS="-Wl,-O0 -Wl,--hash-style=both -pie" \
    PHP_EXTRA_CONFIGURE_ARGS=--enable-maintainer-zts \
    PHP_INI_DIR=/usr/local/etc/php \
    PHP_SOURCE_DIR=/usr/src/php \
    ZEND_DONT_UNLOAD_MODULES=1 \
    CC="ccache gcc" \
    TERM=xterm \
    SSH2_DRIVER_VERSION=1.0 \
    YAML_DRIVER_VERSION=2.0.0 \
    # https://github.com/mongodb/mongo-php-driver/issues/507 (Not compile with latest)
    MONGODB_DRIVER_VERSION=1.1.10

RUN export DEBIAN_FRONTEND=noninteractive \
    && set -x \
    && echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb-src http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    # Fix root terminal
    && echo "export TERM=${TERM}" >> /root/.bashrc \
    # System update
    && /usr/local/bin/apt-upgrade \
    # Install base stuff
    && /usr/local/bin/apt-install \
        autoconf \
        automake \
        bison \
        ca-certificates \
        ccache \
        check \
        cppcheck \
        curl \
        file \
        g++ \
        gcc \
        gdb \
        git \
        libbz2-dev \
        libc-client-dev \
        libc-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libedit2 \
        libfreetype6-dev \
        libgearman-dev \
        libgmp3-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libkrb5-dev \
        libldap2-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libmhash-dev \
        libpng12-dev \
        libpq-dev \
        libpspell-dev \
        librecode-dev \
        libsodium-dev \
        libsqlite3-0 \
        libsqlite3-dev \
        libssh2-1-dev \
        libssl-dev \
        libtidy-dev \
        libtool \
        libxml2 \
        libxml2-dev \
        libxslt-dev \
        libyaml-dev \
        make \
        pkg-config \
        re2c \
        sudo \
        unixodbc \
        unixodbc-dev \
        valgrind \
        wget \
        xz-utils \
    && mkdir -p \
        /usr/src/cphalcon \
        /root/.ccache \
    && chmod agoa+x /usr/local/bin/docker-php* \
    # Install PHP
    && bash /installers/php.sh \
    && ln -s /usr/include/x86_64-linux-gnu /usr/include/gmp.h \
    # Install extensions
    && docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install gmp \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install bz2 \
    && docker-php-ext-install calendar \
    && docker-php-ext-install dba \
    && docker-php-ext-install exif \
    && docker-php-ext-install gettext \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install json \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mysqli \
    && cd /usr/src/php/ext/odbc \
    && phpize \
    && sed -ri 's@^ *test +"\$PHP_.*" *= *"no" *&& *PHP_.*=yes *$@#&@g' configure \
    && ./configure --with-unixODBC=shared,/usr \
    && docker-php-ext-install odbc \
    && docker-php-ext-install opcache \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
    && docker-php-ext-install pdo_odbc \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-install pdo_sqlite \
    && docker-php-ext-install pgsql \
    && docker-php-ext-install pspell \
    && docker-php-ext-install recode \
    && docker-php-ext-install soap \
    && docker-php-ext-install shmop \
    && docker-php-ext-install sockets \
    && docker-php-ext-install sysvmsg \
    && docker-php-ext-install sysvsem \
    && docker-php-ext-install sysvshm \
    && docker-php-ext-install tidy \
    && docker-php-ext-install tokenizer \
    && docker-php-ext-install wddx \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    # Install xdebug
    && printf "\n" | pecl install xdebug \
    && docker-php-ext-enable xdebug \
    # Install yaml
    && printf "\n" | pecl install -a yaml-${YAML_DRIVER_VERSION} \
    && docker-php-ext-enable yaml \
    # Install ssh2
    && printf "\n" | pecl install -a ssh2-${SSH2_DRIVER_VERSION} \
    && docker-php-ext-enable ssh2 \
    # Install msgpack
    && printf "\n" | pecl install -a msgpack \
    && docker-php-ext-enable msgpack \
    # Install libsodium
    && printf "\n" | pecl install -a libsodium \
    && docker-php-ext-enable libsodium \
    # Install mongodb
    && printf "\n" | pecl install -f mongodb-${MONGODB_DRIVER_VERSION} \
    && docker-php-ext-enable mongodb \
    # Install memcached
    && echo $(pkg-config libmemcached --variable=prefix) | pecl install memcached \
    && docker-php-ext-enable memcached \
    # Install igbinary
    && printf "\n" | pecl install -a igbinary \
    && docker-php-ext-enable igbinary \
    # redis
    && printf "\n" | pecl install -a redis \
    && docker-php-ext-enable redis \
    # imagick
    && printf "\n" | pecl install -a imagick \
    && docker-php-ext-enable imagick \
    # Install pinba
    && bash /installers/pinba.sh \
    && docker-php-ext-enable pinba \
    # Install gearman
    && bash /installers/gearman.sh \
    && docker-php-ext-enable gearman \
    # Install handlersocketi
    && bash /installers/handlersocketi.sh \
    && docker-php-ext-enable handlersocketi \
    # nanotime
    && bash /installers/nanotime.sh \
    && docker-php-ext-enable nanotime \
    # Install apcu
    && printf "\n" | pecl install -a apcu \
    && pecl config-set preferred_state beta \
    && printf "\n" | pecl install -a apcu_bc \
    && mv /installers/etc/php/conf.d/00-apc.ini /usr/local/etc/php/conf.d/ \
    # Install Zephir
    && bash /installers/zephir.sh \
    # Cleanup
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf \
        /installers \
        /var/lib/apt/lists/* \
        /var/cache/apt \
        /tmp/* \
        /var/tmp/* \
        /usr/src/php.tar.xz \
        /usr/src/php.tar.xz.asc \
    # Remove unneeded envirnment vars
    && unset MONGODB_DRIVER_VERSION SSH2_DRIVER_VERSION YAML_DRIVER_VERSION

# Set workdir
WORKDIR /usr/src/cphalcon

# Define mountable directories
VOLUME ["/usr/src/cphalcon"]

# Set up the command arguments
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php", "-a"]
