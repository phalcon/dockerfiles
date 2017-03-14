#
# Dockerfile for phalconphp/php:7.1-dev
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM debian:jessie

# Add installers
ADD base.tar /

RUN \
    echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" > /etc/apt/sources.list \
    && echo "deb-src http://httpredir.debian.org/debian jessie main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb-src http://httpredir.debian.org/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        autoconf \
        bison \
        ca-certificates \
        ccache \
        cppcheck \
        curl \
        file \
        g++ \
        gcc \
        gdb \
        git \
        libc-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libedit2 \
        libsqlite3-0 \
        libsqlite3-dev \
        libssl-dev \
        libxml2 \
        libxml2-dev \
        make \
        pkg-config \
        re2c \
        sudo \
        valgrind \
        wget \
        xz-utils \
    # Create required dirs
    && mkdir -p \
        /usr/src \
        /usr/local/etc/php/conf.d \
        /root/.ccache \
    # Install Zephir
    && export ZEPHIRDIR=/usr/share/zephir \
    && mkdir -p $ZEPHIRDIR \
    && git clone -q --depth=1 https://github.com/phalcon/zephir.git /tmp/zephir \
    && cd /tmp/zephir \
    && ./install -c \
    && mkdir -p $PHP_INI_DIR/conf.d \
    && chmod agoa+x /usr/local/bin/docker-php*

ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2" \
    PHP_CPPFLAGS="$PHP_CFLAGS" \
    PHP_LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" \
    GPG_KEYS="A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E" \
    PHP_INI_DIR=/usr/local/etc/php \
    PHP_EXTRA_CONFIGURE_ARGS=--enable-maintainer-zts \
    PHP_VERSION=7.1.2 \
    PHP_URL="https://secure.php.net/get/php-7.1.2.tar.xz/from/this/mirror" \
    PHP_ASC_URL="https://secure.php.net/get/php-7.1.2.tar.xz.asc/from/this/mirror" \
    PHP_SHA256="d815a0c39fd57bab1434a77ff0610fb507c22f790c66cd6f26e27030c4b3e971" \
    PHP_MD5="d79afea1870277c86fac903566fb6c5d" \
    ZEPHIRDIR=/usr/share/zephir

RUN cd /usr/src \
    && wget -O php.tar.xz "$PHP_URL"; \
    if [ -n "$PHP_SHA256" ]; then \
        echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
    fi; \
    if [ -n "$PHP_MD5" ]; then \
        echo "$PHP_MD5 *php.tar.xz" | md5sum -c -; \
    fi; \
    if [ -n "$PHP_ASC_URL" ]; then \
        wget -O php.tar.xz.asc "$PHP_ASC_URL"; \
        export GNUPGHOME="$(mktemp -d)"; \
        for key in $GPG_KEYS; do \
            gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
        done; \
        gpg --batch --verify php.tar.xz.asc php.tar.xz; \
        rm -r "$GNUPGHOME"; \
    fi; \
    export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    && docker-php-source extract \
    && cd /usr/src/php \
    && ./configure \
        --with-config-file-path="$PHP_INI_DIR" \
        --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
        --disable-cgi \
        --enable-ftp \
        --enable-mbstring \
        --enable-mysqlnd \
        --with-curl \
        --with-libedit \
        --with-openssl \
        --with-zlib \
        $PHP_EXTRA_CONFIGURE_ARGS \
    && make -j "$(nproc)" \
    && make install \
    && { find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true; } \
    && make clean \
    # Cleanup
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -r \
        /var/lib/apt/lists/* \
        /tmp/* \
    && export PRE_PHP_INCLUDES=`php-config --includes`

ENV PRE_PHP_INCLUDES=$PRE_PHP_INCLUDES \
    ZEND_DONT_UNLOAD_MODULES=1 \
    CC="ccache gcc"

# Set workdir
WORKDIR /app

# Define mountable directories
VOLUME ["/app"]

# Set up the command arguments
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["php", "-a"]
