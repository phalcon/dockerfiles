#!/bin/bash

printf "\n" | pecl install -a igbinary
echo extension=igbinary.so >/etc/php5/mods-available/igbinary.ini
ln -s /etc/php5/mods-available/igbinary.ini /etc/php5/conf.d/20-igbinary.ini
