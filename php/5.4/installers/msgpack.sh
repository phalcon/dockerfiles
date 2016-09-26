#!/bin/bash

printf "\n" | pecl install -a msgpack-0.5.7 && \
echo extension=msgpack.so > /etc/php5/mods-available/msgpack.ini && \
ln -s /etc/php5/mods-available/msgpack.ini /etc/php5/conf.d/20-msgpack.ini
