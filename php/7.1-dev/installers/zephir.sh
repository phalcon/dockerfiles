#!/usr/bin/env bash

export ZEPHIRDIR=/usr/share/zephir
ZEPHIR_DOWNLOAD_URL=https://github.com/phalcon/zephir.git

mkdir -p $ZEPHIRDIR

git clone -q --depth=1 https://github.com/phalcon/zephir.git /tmp/zephir
cd /tmp/zephir

./install -c