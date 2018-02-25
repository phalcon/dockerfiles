#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

mkdir -p $ZEPHIRDIR
mkdir -p /usr/local/bin

git clone --depth=1 -q https://github.com/phalcon/zephir.git -b ${ZEPHIR_VERSION} ${ZEPHIRDIR} &> /dev/null
cd ${ZEPHIRDIR}

sed "s#%ZEPHIRDIR%#$ZEPHIRDIR#g" bin/zephir > bin/zephir-cmd
chmod 755 bin/zephir-cmd

cp ./bin/zephir-cmd /usr/local/bin/zephir
rm ./bin/zephir-cmd

cd / && zephir help