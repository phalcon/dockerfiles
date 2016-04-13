#!/usr/bin/env bash

printf "\n" | pecl install -a mongo

touch /etc/php5/mods-available/mongo.ini && echo extension=mongo.so > /etc/php5/mods-available/mongo.ini
ln -s /etc/php5/mods-available/mongo.ini /etc/php5/conf.d/
