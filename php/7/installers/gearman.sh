#!/usr/bin/env bash

mkdir -p /tmp/gearman && cd /tmp/gearman

git clone https://github.com/wcgallego/pecl-gearman /tmp/gearman

phpize
./configure
make
make install

touch /etc/php/7.0/mods-available/gearman.ini && echo extension=gearman.so > /etc/php/7.0/mods-available/gearman.ini
ln -s /etc/php/7.0/mods-available/gearman.ini /etc/php/7.0/cli/conf.d/20-gearman.ini
