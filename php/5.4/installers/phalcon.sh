#!/bin/bash

git clone -q https://github.com/phalcon/cphalcon.git /tmp/phalcon-ext
cd /tmp/phalcon-ext
git reset --hard 9c66927

cd /tmp/phalcon-ext/build
./install

echo extension=phalcon.so > /etc/php5/mods-available/phalcon.ini
ln -sf /etc/php5/mods-available/phalcon.ini /etc/php5/conf.d/50-phalcon.ini
