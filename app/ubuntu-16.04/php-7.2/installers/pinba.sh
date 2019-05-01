#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

git clone \
    --depth=1 \
    -q \
    https://github.com/tony2001/pinba_extension.git \
    /tmp/pinba_extension

cd /tmp/pinba_extension

phpize
./configure
make -s -j"$(getconf _NPROCESSORS_ONLN)"
make -s install

php_version=`php -r 'echo phpversion();' | cut -d '.' -f 1,2`
php_ext_dir=`php-config --extension-dir`

mkdir -p /artifacts${php_ext_dir}
mkdir -p /artifacts/etc/php/${php_version}/mods-available

echo "[pinba]" > /etc/php/${php_version}/mods-available/pinba.ini
echo "extension=${php_ext_dir}/pinba.so" >> /etc/php/${php_version}/mods-available/pinba.ini
echo "pinba.server=127.0.0.1" >> /etc/php/${php_version}/mods-available/pinba.ini
echo "pinba.enabled=1" >> /etc/php/${php_version}/mods-available/pinba.ini
echo "pinba.auto_flush=1" >> /etc/php/${php_version}/mods-available/pinba.ini

ln -sf \
   /etc/php/${php_version}/mods-available/pinba.ini \
   /etc/php/${php_version}/cli/conf.d/20-pinba.ini

cp /etc/php/${php_version}/mods-available/pinba.ini /artifacts/etc/php/${php_version}/mods-available
cp ${php_ext_dir}/pinba.so /artifacts${php_ext_dir}

php --ri pinba
