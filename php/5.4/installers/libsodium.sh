#!/bin/bash

printf "\n" | pecl install -a libsodium
echo extension=libsodium.so > /etc/php5/mods-available/libsodium.ini
ln -s /etc/php5/mods-available/libsodium.ini /etc/php5/conf.d/20-libsodium.ini
