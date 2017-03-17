#!/usr/bin/env bash

git clone --depth=1 -v https://github.com/tony2001/php-ext-handlersocketi.git -b badoo-7.0 /tmp/handlersocketi-ext
cd /tmp/handlersocketi-ext

phpize &> /dev/null
./configure --silent &> /dev/null

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make --silent install