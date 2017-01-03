#!/bin/bash

printf "\n" | pecl install weakref-0.3.3 &> /dev/null

touch /etc/php/7.0/mods-available/weakref.ini
echo  extension=weakref.so > /etc/php/7.0/mods-available/weakref.ini

ln -sf /etc/php/7.0/mods-available/weakref.ini /etc/php/7.0/cli/conf.d/25-weakref.ini
ln -sf /etc/php/7.0/mods-available/weakref.ini /etc/php/7.0/fpm/conf.d/25-weakref.ini
