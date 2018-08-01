#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

if [ ! -z "$(find /entrypoint.d -maxdepth 0 -type f  -name \"*.sh\" 2>/dev/null)" ]; then
    for file in /entrypoint.d/*.sh; do
    	source "${file}"
    done
fi

# Start all services
/usr/bin/supervisord -n
