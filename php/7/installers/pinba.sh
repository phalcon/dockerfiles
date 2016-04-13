#!/usr/bin/env bash

PHP_EXT_DIR=`php-config --extension-dir`

mkdir -p /tmp/pinba-ext && cd /tmp/pinba-ext

git clone https://github.com/tony2001/pinba_extension.git -b php7 && cd pinba_extension

phpize
./configure

make
make install

mv /tmp/pinba-ext/pinba_extension/modules/pinba.so "${PHP_EXT_DIR}/pinba.so"

touch /etc/php/7.0/mods-available/pinba.ini && echo extension=pinba.so > /etc/php/7.0/mods-available/pinba.ini
ln -s /etc/php/7.0/mods-available/pinba.ini /etc/php/7.0/cli/conf.d/20-pinba.ini
