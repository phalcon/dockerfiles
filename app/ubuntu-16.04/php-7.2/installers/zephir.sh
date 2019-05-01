#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

mkdir -p /usr/local/bin

wget --quiet -O /usr/local/bin/zephir \
     "https://github.com/phalcon/zephir/releases/download/${ZEPHIR_VERSION}/zephir.phar"

chmod +x /usr/local/bin/zephir

mkdir -p /artifacts/usr/local/bin
cp /usr/local/bin/zephir /artifacts/usr/local/bin

zephir --version
