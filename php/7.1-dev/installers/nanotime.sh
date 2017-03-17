#!/usr/bin/env bash

git clone --depth=1 -v https://github.com/lstrojny/nanotime.git /tmp/libnanotime
cd /tmp/libnanotime

./autogen.sh

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make check
make --silent install

ln -s /usr/local/lib/libnanotime-1.0.0.so /usr/lib/libnanotime-1.0.0.so.0

git clone --depth=1 -v https://github.com/sergeyklay/php-nanotime.git /tmp/ext-nanotime
cd /tmp/ext-nanotime

phpize &> /dev/null
./configure --silent --with-libnanotime-prefix=/usr/local &> /dev/null

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make --silen install