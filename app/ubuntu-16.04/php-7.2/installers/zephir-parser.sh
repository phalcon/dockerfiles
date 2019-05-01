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
make -s -j"$(getconf _NPROCESSORS_ONLN)"
make -s install

php_version=`php -r 'echo phpversion();' | cut -d '.' -f 1,2`
php_include_dir=`php-config --include-dir`
php_ext_dir=`php-config --extension-dir`

echo "[Zephir Parser]" > /etc/php/${php_version}/mods-available/zephir_parser.ini
echo "extension=zephir_parser.so" >> /etc/php/${php_version}/mods-available/zephir_parser.ini

ln -sf \
   /etc/php/${php_version}/mods-available/zephir_parser.ini \
   /etc/php/${php_version}/cli/conf.d/50-zephir_parser.ini

mkdir -p /artifacts${php_ext_dir}
mkdir -p /artifacts${php_include_dir}/ext
mkdir -p /artifacts/etc/php/${php_version}/mods-available

cp /etc/php/${php_version}/mods-available/zephir_parser.ini /artifacts/etc/php/${php_version}/mods-available
cp ${php_ext_dir}/zephir_parser.so /artifacts${php_ext_dir}
cp -R ${php_include_dir}/ext/zephir_parser /artifacts/${php_include_dir}/ext

php --ri "Zephir Parser"
