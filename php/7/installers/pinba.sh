#!/usr/bin/env bash

PHP_EXT_DIR=`php-config --extension-dir`

mkdir -p /tmp/pinba-ext && cd /tmp/pinba-ext

git clone --depth=1 -q https://github.com/tony2001/pinba_extension.git /tmp/pinba_extension && cd /tmp/pinba_extension

phpize
./configure

make
make install

mv /tmp/pinba_extension/modules/pinba.so "${PHP_EXT_DIR}/pinba.so"

touch /etc/php/7.0/mods-available/pinba.ini && echo extension=pinba.so > /etc/php/7.0/mods-available/pinba.ini
ln -s /etc/php/7.0/mods-available/pinba.ini /etc/php/7.0/cli/conf.d/20-pinba.ini
