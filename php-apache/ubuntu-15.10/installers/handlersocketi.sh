#!/bin/bash

git clone --depth=1 -q -b badoo-5.6 https://github.com/tony2001/php-ext-handlersocketi.git /tmp/handlersocketi-ext && cd /tmp/handlersocketi-ext

phpize
./configure

make
make install

mv /tmp/handlersocketi-ext/modules/handlersocketi.so /usr/lib/php5/20131226/

touch /etc/php5/mods-available/handlersocketi.ini
echo extension=handlersocketi.so > /etc/php5/mods-available/handlersocketi.ini

ln -s /etc/php5/mods-available/handlersocketi.ini /etc/php5/cli/conf.d/20-handlersocketi.ini
ln -s /etc/php5/mods-available/handlersocketi.ini /etc/php5/fpm/conf.d/20-handlersocketi.ini
