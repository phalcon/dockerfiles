#!/usr/bin/env bash

mkdir -p /tmp/memcached && cd /tmp/memcached

git clone https://github.com/php-memcached-dev/php-memcached.git -b php7 /tmp/memcached

phpize
./configure --disable-memcached-sasl
make
make install

touch /etc/php/7.0/mods-available/memcached.ini && echo extension=memcached.so > /etc/php/7.0/mods-available/memcached.ini
ln -s /etc/php/7.0/mods-available/memcached.ini /etc/php/7.0/cli/conf.d/20-memcached.ini
