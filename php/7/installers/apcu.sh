#!/usr/bin/env bash

mkdir -p /tmp/apcu && cd /tmp/apcu

git clone https://github.com/krakjoe/apcu /tmp/apcu

phpize
./configure
make -j 4
make install

touch /etc/php/7.0/mods-available/apcu.ini

echo extension=apcu.so > /etc/php/7.0/mods-available/apcu.ini
echo apc.enable_cli=On >> /etc/php/7.0/mods-available/apcu.ini

ln -s /etc/php/7.0/mods-available/apcu.ini /etc/php/7.0/cli/conf.d/20-apcu.ini
