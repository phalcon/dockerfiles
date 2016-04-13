#!/usr/bin/env bash

CFLAGS="-O1 -g3 -fno-strict-aliasing -std=gnu90"

mkdir -p /tmp/redis && cd /tmp/redis

git clone https://github.com/phpredis/phpredis/ -b php7 /tmp/redis

phpize
./configure --enable-redis-igbinary
make
make install

touch /etc/php/7.0/mods-available/redis.ini && echo extension=redis.so > /etc/php/7.0/mods-available/redis.ini
ln -s /etc/php/7.0/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini
