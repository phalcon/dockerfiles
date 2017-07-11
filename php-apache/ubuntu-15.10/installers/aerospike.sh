#!/bin/bash

git clone --depth=1 -q https://github.com/aerospike/aerospike-client-php /tmp/aerospike-ext && cd /tmp/aerospike-ext/src/aerospike

ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/local/lib/libcrypto.so
ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/local/lib/libcrypto.a

DOWNLOAD_PHP_UNIT=0 ./build.sh --loglevel OFF
make install

echo extension=aerospike.so > /etc/php5/mods-available/aerospike.ini
echo aerospike.udf.lua_system_path=/usr/local/aerospike/lua >> /etc/php5/mods-available/aerospike.ini
echo aerospike.udf.lua_user_path=/usr/local/aerospike/usr-lua >> /etc/php5/mods-available/aerospike.ini

ln -s /etc/php5/mods-available/aerospike.ini /etc/php5/cli/conf.d/20-aerospike.ini
ln -s /etc/php5/mods-available/aerospike.ini /etc/php5/fpm/conf.d/20-aerospike.ini
