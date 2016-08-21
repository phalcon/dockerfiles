#!/usr/bin/env bash

mkdir -p /tmp/aerospike-ext
cd /tmp/aerospike-ext

wget -O aerospike.zip https://github.com/aerospike/aerospike-client-php/archive/master.zip
unzip aerospike.zip

cd aerospike-client-php-master/src/aerospike
./build.sh
make install

ls -al /usr/local/aerospike/

echo 'extension=aerospike.so' | tee /etc/php/7.0/mods-available/aerospike.ini
echo 'aerospike.udf.lua_system_path=/usr/local/aerospike/lua' | tee -a /etc/php/7.0/mods-available/aerospike.ini
echo 'aerospike.udf.lua_user_path=/usr/local/aerospike/usr-lua' | tee -a /etc/php/7.0/mods-available/aerospike.ini

ln -s /etc/php/7.0/mods-available/aerospike.ini /etc/php/7.0/cli/conf.d/20-aerospike.ini
