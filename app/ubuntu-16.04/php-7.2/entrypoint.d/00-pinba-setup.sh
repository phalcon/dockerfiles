#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

# Set pinba server
if [ "x${PINBA_SERVER}" != "x" ]; then
    sed -i -e "s/pinba.server[ \t]*=[ \t]*\(.*\)$/pinba.server = ${PINBA_SERVER}/g" \
        /etc/php/7.2/mods-available/pinba.ini

    phpenmod -v 7.2 pinba
fi
