#!/bin/bash

git clone --depth=1 -q https://github.com/phpredis/phpredis/ /tmp/redis && cd /tmp/redis

phpize
./configure

make
make install

touch /etc/php5/mods-available/redis.ini
echo extension=redis.so > /etc/php5/mods-available/redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/conf.d/20-redis.ini
