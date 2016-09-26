#!/bin/bash

printf "\n" | pecl install -a gearman
echo extension=gearman.so > /etc/php5/mods-available/gearman.ini
ln -s /etc/php5/mods-available/gearman.ini /etc/php5/conf.d/20-gearman.ini
