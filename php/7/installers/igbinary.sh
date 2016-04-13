#!/usr/bin/env bash

PHP_EXT_DIR=`php-config --extension-dir`
CFLAGS="-O2 -g3 -fno-strict-aliasing -std=gnu90"

mkdir -p /tmp/igbinary && cd /tmp/igbinary

git clone https://github.com/igbinary/igbinary7 /tmp/igbinary

phpize
./configure --enable-igbinary
make
make test
make install

touch /etc/php/7.0/mods-available/igbinary.ini && echo extension=igbinary.so > /etc/php/7.0/mods-available/igbinary.ini
ln -s /etc/php/7.0/mods-available/igbinary.ini /etc/php/7.0/cli/conf.d/20-igbinary.ini
