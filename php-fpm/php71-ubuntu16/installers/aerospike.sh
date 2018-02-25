#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

git clone --depth=1 -q https://github.com/aerospike/aerospike-client-php /tmp/aerospike-ext &> /dev/null
cd /tmp/aerospike-ext/src

ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.so /usr/local/lib/libcrypto.so
ln -sf /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/local/lib/libcrypto.a

bash ./build.sh --loglevel OFF
make -s -j"$(getconf _NPROCESSORS_ONLN)" install

# artifacts
cp "$(php-config --extension-dir)/aerospike.so" /artifacts/
cp -r /usr/local/aerospike /artifacts/