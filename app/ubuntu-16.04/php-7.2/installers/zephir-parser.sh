#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

git clone \
    --depth=1 \
    -q \
    https://github.com/phalcon/php-zephir-parser.git \
    -b ${ZEPHIR_PARSER_VERSION} /tmp/zephir_parser

cd /tmp/zephir_parser

phpize
./configure
make
make install

echo "[Zephir Parser]" > /etc/php/7.2/mods-available/zephir_parser.ini
echo "extension=zephir_parser.so" >> /etc/php/7.2/mods-available/zephir_parser.ini

phpversion=`php -r 'echo phpversion();' | cut -d '.' -f 1,2`

ln -sf \
   /etc/php/${phpversion}/mods-available/zephir_parser.ini \
   /etc/php/${phpversion}/cli/conf.d/50-zephir_parser.ini

mkdir -p /artifacts/`php-config --extension-dir`/ext
mkdir -p /artifacts/`php-config --include-dir`
mkdir -p /artifacts/etc/php/${phpversion}/mods-available

cp `php-config --extension-dir`/zephir_parser.so /artifacts/`php-config --extension-dir`
cp -R `php-config --include-dir`/ext/zephir_parser /artifacts/`php-config --extension-dir`/ext

php --ri "Zephir Parser"
