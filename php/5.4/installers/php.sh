#!/bin/bash

find /etc/php5/mods-available/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php5/cli/php.ini
sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php5/cli/php.ini
sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php5/cli/php.ini
sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php5/cli/php.ini
sed -i 's|display_errors =.*|display_errors = On|' /etc/php5/cli/php.ini
sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php5/cli/php.ini

sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php5/cli/php.ini
sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php5/cli/php.ini

echo apc.enable_cli=1 >> /etc/php5/mods-available/apc.ini
