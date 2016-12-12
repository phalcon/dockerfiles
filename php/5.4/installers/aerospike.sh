#!/bin/bash

git clone --depth=1 -q https://github.com/aerospike/aerospike-client-php /tmp/aerospike-ext && cd /tmp/aerospike-ext/src/aerospike

ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/local/lib/libcrypto.so
ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/local/lib/libcrypto.a

DOWNLOAD_PHP_UNIT=0 ./build.sh -l OFF || exit 1
make install

echo extension=aerospike.so > /etc/php5/mods-available/aerospike.ini
echo aerospike.udf.lua_system_path=/usr/local/aerospike/lua >> /etc/php5/mods-available/aerospike.ini
echo aerospike.udf.lua_user_path=/usr/local/aerospike/usr-lua >> /etc/php5/mods-available/aerospike.ini

ln -sf /etc/php5/mods-available/aerospike.ini /etc/php5/conf.d/20-aerospike.ini
