#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

cd /tmp

wget --quiet -O /tmp/openssl.tar.gz \
     "https://www.openssl.org/source/$OPENSSL_VERSION.tar.gz"

tar -xzf openssl.tar.gz
cd $OPENSSL_VERSION

./config --prefix=/usr
make -s -j"$(getconf _NPROCESSORS_ONLN)"
make -s install
