#!/usr/bin/env bash

PHP_VERSION=7.1.3

SOURCE_DIR=/usr/src
PHP_SOURCE_DIR=/usr/src/php

PHP_ASC_URL="https://secure.php.net/get/php-${PHP_VERSION}.tar.xz.asc/from/this/mirror"
PHP_DOWNLOAD_URL="https://secure.php.net/get/php-${PHP_VERSION}.tar.xz/from/this/mirror"

PHP_GPG_KEYS="A917B1ECDA84AEC2B568FED6F50ABC807BD5DCD0 528995BFEDFBA7191D46839EF9BA0ADA31CBD89E"
PHP_SHA256="e4887c2634778e37fd962fbdf5c4a7d32cd708482fe07b448804625570cb0bb0"
PHP_MD5="d604d688be17f4a05b99dbb7fb9581f4"

CFLAGS="$PHP_CFLAGS"
CPPFLAGS="$PHP_CPPFLAGS"
LDFLAGS="$PHP_LDFLAGS"

mkdir -p "${PHP_INI_DIR}/conf.d"
mkdir -p "${PHP_SOURCE_DIR}"

cd ${SOURCE_DIR}

wget -O php.tar.xz "$PHP_DOWNLOAD_URL"

echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -
echo "$PHP_MD5 *php.tar.xz" | md5sum -c -

wget -O php.tar.xz.asc "$PHP_ASC_URL";

export GNUPGHOME="$(mktemp -d)"

for key in $PHP_GPG_KEYS; do
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"
done;

gpg --batch --verify php.tar.xz.asc php.tar.xz;
rm -r "$GNUPGHOME"

docker-php-source extract

cd ${PHP_SOURCE_DIR}

./configure \
	--with-config-file-path="$PHP_INI_DIR" \
	--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
	--enable-debug \
	--enable-maintainer-zts \
	--enable-cgi \
	--enable-cli \
	--enable-ftp \
	--enable-mbstring \
	--enable-mysqlnd \
	--with-curl \
	--with-libedit \
	--with-openssl \
	--with-zlib \
	$PHP_EXTRA_CONFIGURE_ARGS

make -j"$(getconf _NPROCESSORS_ONLN)"
make install

find /usr/local/bin /usr/local/sbin -type f -executable -exec strip --strip-all '{}' + || true

make clean
