#!/usr/bin/env bash

mkdir -p /tmp/handlersocketi-ext && cd /tmp/handlersocketi-ext

git clone https://github.com/tony2001/php-ext-handlersocketi.git -b badoo && cd php-ext-handlersocketi

phpize
./configure

make
make install

mv /tmp/handlersocketi-ext/php-ext-handlersocketi/modules/handlersocketi.so "${PHP_EXT_DIR}/handlersocketi.so"

touch /etc/php5/mods-available/handlersocketi.ini && echo extension=handlersocketi.so > /etc/php5/mods-available/handlersocketi.ini
ln -s /etc/php5/mods-available/handlersocketi.ini /etc/php5/cli/conf.d/30-handlersocketi.ini
