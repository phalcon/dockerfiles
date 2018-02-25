#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

git clone --depth=1 -q https://github.com/tony2001/pinba_extension.git /tmp/pinba_extension &> /dev/null
cd /tmp/pinba_extension

phpize
./configure

make -s -j"$(getconf _NPROCESSORS_ONLN)"
make -s install
mv /tmp/pinba_extension/modules/pinba.so /artifacts/pinba.so