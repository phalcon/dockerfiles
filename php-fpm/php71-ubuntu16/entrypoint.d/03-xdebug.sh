#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

if [ "x${XDEBUG_REMOTE_PORT}" != "x" ]; then
	/usr/local/bin/go-replace --regex \
		-s 'xdebug.remote_port[\s]*=[\s]*(.*)$' -r "xdebug.remote_port = ${XDEBUG_REMOTE_PORT}" \
		/etc/php/7.1/mods-available/xdebug.ini
fi

if [ "x${XDEBUG_REMOTE_AUTO_START}" != "x" ]; then
	/usr/local/bin/go-replace --regex \
		-s 'xdebug.remote_autostart [\s]*=[\s]*(.*)$' -r "xdebug.remote_autostart = ${XDEBUG_REMOTE_AUTO_START}" \
		/etc/php/7.1/mods-available/xdebug.ini
fi

if [ "x${XDEBUG_REMOTE_ENABLE}" != "x" ]; then
	/usr/local/bin/go-replace --regex \
		-s 'xdebug.remote_enable [\s]*=[\s]*(.*)$' -r "xdebug.remote_enable = ${XDEBUG_REMOTE_ENABLE}" \
		/etc/php/7.1/mods-available/xdebug.ini
fi

# Enable xdebug if env.var ${XDEBUG_REMOTE_HOST} is defined
if [ "x${XDEBUG_REMOTE_HOST}" != "x" ]; then
	if [ ${XDEBUG_REMOTE_HOST} == "auto" ]; then
		export XDEBUG_REMOTE_HOST=$(/sbin/ip route|awk '/default/ { print $3 }')
	fi

	/usr/local/bin/go-replace --regex \
		-s 'xdebug.remote_host[\s]*=[\s]*(.*)$' -r "xdebug.remote_host = ${XDEBUG_REMOTE_HOST}" \
		/etc/php/7.1/mods-available/xdebug.ini

	phpenmod -v 7.1 xdebug
fi
