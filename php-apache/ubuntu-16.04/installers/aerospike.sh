#!/bin/bash

git clone --depth=1 -q https://github.com/aerospike/aerospike-client-php /tmp/aerospike-ext && cd /tmp/aerospike-ext/src/aerospike

ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/local/lib/libcrypto.so
ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/local/lib/libcrypto.a

DOWNLOAD_PHP_UNIT=0 ./build.sh -l ERROR
make install

echo extension=aerospike.so > /etc/php/7.0/mods-available/aerospike.ini
echo aerospike.udf.lua_system_path=/usr/local/aerospike/lua >> /etc/php/7.0/mods-available/aerospike.ini
echo aerospike.udf.lua_user_path=/usr/local/aerospike/usr-lua >> /etc/php/7.0/mods-available/aerospike.ini

ln -s /etc/php/7.0/mods-available/aerospike.ini /etc/php/7.0/cli/conf.d/20-aerospike.ini
ln -s /etc/php/7.0/mods-available/aerospike.ini /etc/php/7.0/fpm/conf.d/20-aerospike.ini
