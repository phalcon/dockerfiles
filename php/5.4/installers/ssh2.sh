#!/bin/bash

printf "\n" | pecl install -a ssh2-0.13
echo extension=ssh2.so > /etc/php5/mods-available/ssh2.ini
ln -s /etc/php5/mods-available/ssh2.ini /etc/php5/conf.d/20-ssh2.ini
