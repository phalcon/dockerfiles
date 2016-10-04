#!/bin/bash

git clone --depth=1 -q -b badoo-7.0 https://github.com/tony2001/php-ext-handlersocketi.git /tmp/handlersocketi-ext && cd /tmp/handlersocketi-ext

phpize
./configure

make
make install

mv /tmp/handlersocketi-ext/modules/handlersocketi.so /usr/lib/php/20151012/

touch /etc/php/7.0/mods-available/handlersocketi.ini
echo extension=handlersocketi.so > /etc/php/7.0/mods-available/handlersocketi.ini

ln -s /etc/php/7.0/mods-available/handlersocketi.ini /etc/php/7.0/cli/conf.d/20-handlersocketi.ini
ln -s /etc/php/7.0/mods-available/handlersocketi.ini /etc/php/7.0/apache2/conf.d/20-handlersocketi.ini
