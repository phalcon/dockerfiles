#!/usr/bin/env bash

PHP_EXT_DIR=`php-config --extension-dir`

git clone --depth=1 -q -b php5 https://github.com/tony2001/pinba_extension.git /tmp/pinba_extension && cd /tmp/pinba_extension

phpize
./configure

make
make install

mv /tmp/pinba_extension/modules/pinba.so "${PHP_EXT_DIR}/pinba.so"

touch /etc/php5/mods-available/pinba.ini && echo extension=pinba.so > /etc/php5/mods-available/pinba.ini
ln -s /etc/php5/mods-available/pinba.ini /etc/php5/conf.d/20-pinba.ini
