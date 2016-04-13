#!/usr/bin/env bash

mkdir -p /tmp/redis && cd /tmp/redis

git clone https://github.com/phpredis/phpredis/ /tmp/redis

phpize
./configure
make
make install

touch /etc/php5/mods-available/redis.ini && echo extension=redis.so > /etc/php5/mods-available/redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/conf.d/20-redis.ini
