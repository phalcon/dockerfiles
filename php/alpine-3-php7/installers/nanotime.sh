#!/usr/bin/env bash

git clone --depth=1 -v https://github.com/lstrojny/nanotime.git /tmp/libnanotime
cd /tmp/libnanotime

./autogen.sh

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make check
make --silent install

git clone --depth=1 -v https://github.com/sergeyklay/php-nanotime.git /tmp/ext-nanotime
cd /tmp/ext-nanotime

phpize
./configure --with-libnanotime-prefix=/usr/local

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make --silen install

echo "extension=nanotime.so" > /etc/php7/conf.d/20-nanotime.ini

make test
