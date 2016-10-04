#!/bin/bash

git clone --depth=1 -q https://github.com/tony2001/pinba_extension.git /tmp/pinba_extension && cd /tmp/pinba_extension

phpize
./configure

make
make install

mv /tmp/pinba_extension/modules/pinba.so /usr/lib/php/20151012/

touch /etc/php/7.0/mods-available/pinba.ini
echo extension=pinba.so > /etc/php/7.0/mods-available/pinba.ini

ln -s /etc/php/7.0/mods-available/pinba.ini /etc/php/7.0/cli/conf.d/20-pinba.ini
ln -s /etc/php/7.0/mods-available/pinba.ini /etc/php/7.0/apache2/conf.d/20-pinba.ini
