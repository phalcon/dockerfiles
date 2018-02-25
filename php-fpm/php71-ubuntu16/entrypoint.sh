#!/usr/bin/env bash

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

for file in /entrypoint.d/*.sh; do
	source "$file"
done

# Start all services
/usr/bin/supervisord -n
