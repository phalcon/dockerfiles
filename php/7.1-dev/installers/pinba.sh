#!/usr/bin/env bash

git clone --depth=1 -q https://github.com/tony2001/pinba_extension.git /tmp/pinba-ext
cd /tmp/pinba-ext

phpize &> /dev/null
./configure --silent &> /dev/null

make --silent -j"$(getconf _NPROCESSORS_ONLN)" &> /dev/null
make --silent install
