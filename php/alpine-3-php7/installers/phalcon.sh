#!/bin/bash

git clone -q https://github.com/phalcon/cphalcon.git /tmp/phalcon-ext
cd /tmp/phalcon-ext/build

./install
echo extension=phalcon.so > /etc/php7/conf.d/50-phalcon.ini
