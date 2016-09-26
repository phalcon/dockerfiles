#!/bin/bash

pecl install xdebug

echo '[Xdebug]' > /etc/php5/mods-available/xdebug.ini
echo 'zend_extension = /usr/lib/php5/20100525/xdebug.so' >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_enable = 1" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_host = 0.0.0.0" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_port = 9001" >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.remote_handler = "dbgp"' >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php5/mods-available/xdebug.ini
echo "xdebug.cli_color = 1" >> /etc/php5/mods-available/xdebug.ini
echo 'xdebug.idekey = "PHPSTORM"' >> /etc/php5/mods-available/xdebug.ini

ln -sf /etc/php5/mods-available/xdebug.ini /etc/php5/conf.d/20-xdebug.ini
