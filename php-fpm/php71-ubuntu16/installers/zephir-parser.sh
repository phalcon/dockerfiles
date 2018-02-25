#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

git clone --depth=1 -q https://github.com/phalcon/php-zephir-parser.git -b ${ZEPHIR_PARSER_VERSION} /tmp/php-zephir-parser &> /dev/null
cd /tmp/php-zephir-parser

./install

echo "[Zephir Parser]" > /etc/php/7.1/mods-available/zephir_parser.ini
echo "extension=zephir_parser.so" >> /etc/php/7.1/mods-available/zephir_parser.ini

ln -sf /etc/php/7.1/mods-available/zephir_parser.ini /etc/php/7.1/cli/conf.d/50-zephir_parser.ini
php --ri 'Zephir Parser'