#!/usr/bin/env bash

cd /tmp
wget https://github.com/phpredis/phpredis/archive/master.zip -O phpredis.zip

unzip -o /tmp/phpredis.zip && mv /tmp/phpredis-* /tmp/phpredis && cd /tmp/phpredis && phpize && ./configure && make && make install

touch /etc/php5/mods-available/redis.ini && echo extension=redis.so > /etc/php5/mods-available/redis.ini
ln -s /etc/php5/mods-available/redis.ini /etc/php5/conf.d/
