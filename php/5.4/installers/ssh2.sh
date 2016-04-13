#!/usr/bin/env bash

printf "\n" | pecl install -a ssh2-0.12

touch /etc/php5/mods-available/ssh2.ini && echo extension=ssh2.so > /etc/php5/mods-available/ssh2.ini
ln -s /etc/php5/mods-available/ssh2.ini /etc/php5/conf.d/
