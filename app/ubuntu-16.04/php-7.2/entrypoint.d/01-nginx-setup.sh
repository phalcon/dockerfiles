#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

if [ "x${NGINX_RESOLVER}" != "x" ]; then
    sed -i "s/NGINX_RESOLVER/${NGINX_RESOLVER}/g" \
        /etc/nginx/directives/resolver.conf
fi
