#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

targz_download_and_extract() {
    source=$1
    destination=$2
    cd /tmp
    wget -O $destination $source
    tar -xzf $destination
}

git clone \
    --depth=1 \
    -q \
    https://github.com/tony2001/ngx_http_pinba_module.git \
    /tmp/pinba

git clone \
    --depth=1 \
    -q \
    https://github.com/leev/ngx_http_geoip2_module.git \
    /tmp/ngx_http_geoip2_module

git clone \
    --depth=1 \
    -q \
    https://github.com/arut/nginx-dav-ext-module \
    /tmp/nginx-dav-ext-module

targz_download_and_extract \
    "https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.gz" \
    /tmp/pcre.tar.gz

mv /tmp/pcre-${PCRE_VERSION} $PCRE_PATH

targz_download_and_extract \
    "https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" \
    /tmp/nginx.tar.gz

cd /tmp/nginx-${NGINX_VERSION}

./configure --prefix=/usr/share/nginx \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=$NGINX_CONF_PATH/nginx.conf\
            --error-log-path=$NGINX_LOG_PATH/error.log \
            --http-log-path=$NGINX_LOG_PATH/access.log \
            --pid-path=/run/nginx.pid \
            --lock-path=/var/lock/nginx.lock \
            --user=$NGINX_USER \
            --group=$NGINX_USER \
            --build=$NGINX_BUILD \
            --add-module=/tmp/pinba/ \
            --add-module=/tmp/ngx_http_geoip2_module \
            --with-pcre=$PCRE_PATH \
            --with-http_realip_module \
            --with-http_geoip_module \
            --with-http_gzip_static_module \
            --with-http_stub_status_module \
            --with-http_ssl_module \
            --with-openssl=/tmp/$OPENSSL_VERSION \
            --with-http_dav_module \
            --add-module=/tmp/nginx-dav-ext-module

make -s -j"$(getconf _NPROCESSORS_ONLN)"
make -s install
