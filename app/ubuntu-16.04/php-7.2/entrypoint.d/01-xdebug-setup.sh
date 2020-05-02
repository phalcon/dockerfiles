#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

if [ "x${XDEBUG_REMOTE_PORT}" != "x" ]; then
    sed -i -e "s/xdebug.remote_port[ \t]*=[ \t]*\(.*\)$/xdebug.remote_port = ${XDEBUG_REMOTE_PORT}/g" \
        /etc/php/7.2/mods-available/xdebug.ini
fi

if [ "x${XDEBUG_REMOTE_AUTO_START}" != "x" ]; then
    sed -i -e "s/xdebug.remote_autostart[ \t]*=[ \t]*\(.*\)$/xdebug.remote_autostart = ${XDEBUG_REMOTE_AUTO_START}/g" \
        /etc/php/7.2/mods-available/xdebug.ini
fi

if [ "x${XDEBUG_REMOTE_ENABLE}" != "x" ]; then
    sed -i -e "s/xdebug.remote_enable[ \t]*=[ \t]*\(.*\)$/xdebug.remote_enable = ${XDEBUG_REMOTE_ENABLE}/g" \
        /etc/php/7.2/mods-available/xdebug.ini

    # Setting XDEBUG_REMOTE_ENABLE=1 will enable xdebug
    case $XDEBUG_REMOTE_ENABLE in
	"1"|"on"|"On"|"ON"|"true"|"True"|"TRUE")
	    phpenmod -v 7.2 xdebug;
	    ;;
    esac
fi

# Enable xdebug if XDEBUG_REMOTE_HOST is defined
if [ "x${XDEBUG_REMOTE_HOST}" != "x" ]; then
    if [ ${XDEBUG_REMOTE_HOST} == "auto" ]; then
	export XDEBUG_REMOTE_HOST=$(/sbin/ip route|awk '/default/ { print $3 }')
    fi

    sed -i -e "s/xdebug.remote_host[ \t]*=[ \t]*\(.*\)$/xdebug.remote_host = ${XDEBUG_REMOTE_HOST}/g" \
        /etc/php/7.2/mods-available/xdebug.ini

	phpenmod -v 7.2 xdebug
fi
