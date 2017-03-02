#!/usr/bin/env bash

git clone --depth=1 -v https://github.com/wcgallego/pecl-gearman.git /tmp/ext-gearman
cd /tmp/ext-gearman

phpize &> /dev/null
./configure --silent &> /dev/null

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make --silent install

echo "extension=gearman.so" > /etc/php7/conf.d/20-gearman.ini
