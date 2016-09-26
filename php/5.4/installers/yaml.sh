#!/bin/bash

printf "\n" | pecl install yaml
echo extension=yaml.so > /etc/php5/mods-available/yaml.ini
ln -s /etc/php5/mods-available/yaml.ini /etc/php5/conf.d/20-yaml.ini
