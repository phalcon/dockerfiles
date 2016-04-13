#!/usr/bin/env bash

printf "\n" | pecl install -a gearman

touch /etc/php5/mods-available/gearman.ini && echo extension=gearman.so > /etc/php5/mods-available/gearman.ini
ln -s /etc/php5/mods-available/gearman.ini /etc/php5/conf.d/
