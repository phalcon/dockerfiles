#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

# Set pinba server
if [ "x${PINBA_SERVER}" != "x" ]; then
	/usr/local/bin/go-replace \
		-s '127.0.0.1' -r "${PINBA_SERVER}" \
		/etc/php/7.1/mods-available/pinba.ini

	phpenmod -v 7.1 pinba
fi
