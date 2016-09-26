#!/bin/bash

PHP_EXT_DIR=`php-config --extension-dir`

git clone --depth=1 -q -b badoo https://github.com/tony2001/php-ext-handlersocketi.git /tmp/handlersocketi-ext && cd /tmp/handlersocketi-ext

phpize
./configure

make
make install

mv /tmp/handlersocketi-ext/modules/handlersocketi.so "${PHP_EXT_DIR}/handlersocketi.so"

touch /etc/php5/mods-available/handlersocketi.ini
echo extension=handlersocketi.so > /etc/php5/mods-available/handlersocketi.ini
ln -s /etc/php5/mods-available/handlersocketi.ini /etc/php5/conf.d/20-handlersocketi.ini
