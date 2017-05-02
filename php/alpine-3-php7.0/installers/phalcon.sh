#!/bin/bash

# Use stable version
git clone --depth=1 -v https://github.com/phalcon/cphalcon.git /tmp/phalcon-ext
cd /tmp/phalcon-ext/build

./install
