#!/bin/bash

printf "\n" | pecl install weakref-0.3.3 &> /dev/null

touch /etc/php5/mods-available/weakref.ini
echo  extension=weakref.so > /etc/php5/mods-available/weakref.ini

ln -sf /etc/php5/mods-available/weakref.ini /etc/php5/cli/conf.d/25-weakref.ini
ln -sf /etc/php5/mods-available/weakref.ini /etc/php5/fpm/conf.d/25-weakref.ini
