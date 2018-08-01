#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

NGINX_TAR_NAME="${SETUP_DIR}/nginx.tar.gz"
NGINX_URL="https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz"
PCRE_URL="https://ftp.pcre.org/pub/pcre/pcre-${PCRE_VERSION}.tar.gz"

mkdir -p /opt /var/lock
mkdir -p /etc/nginx/conf.d
mkdir -p /var/log/nginx

targz_download_and_extract() {
	source=$1
	destination=$2
	cd $SETUP_DIR
	curl -sSL $source -o $destination
	tar -xzf $destination
}

git clone --depth=1 -q https://github.com/tony2001/ngx_http_pinba_module.git $SETUP_DIR/pinba
git clone --depth=1 -q https://github.com/jiaz/nginx-http-json-log $SETUP_DIR/nginx-json-log

targz_download_and_extract $PCRE_URL $SETUP_DIR/pcre.tar.gz
mv $SETUP_DIR/pcre-${PCRE_VERSION} $PCRE_PATH

targz_download_and_extract $NGINX_URL $SETUP_DIR/nginx.tar.gz
cd  $SETUP_DIR/nginx-${NGINX_VERSION}

./configure \
	--prefix=/usr/share/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=$NGINX_CONF_PATH/nginx.conf\
	--error-log-path=/var/log/nginx/error.log \
	--http-log-path=/var/log/nginx/access.log \
	--pid-path=/var/run/nginx.pid \
	--lock-path=/var/lock/nginx.lock \
	--user=$NGINX_USER \
	--group=$NGINX_USER \
	--build=$NGINX_BUILD \
	--add-module=$SETUP_DIR/pinba/ \
	--add-module=$SETUP_DIR/nginx-json-log \
	--with-pcre=$PCRE_PATH \
	--with-http_ssl_module \
	--with-http_v2_module \
	--with-http_realip_module \
	--with-http_geoip_module \
	--with-http_gzip_static_module \
	--with-http_stub_status_module \
	--with-http_addition_module

make -s
make -s install

if [ -d /etc/nginx ]; then
	mv /etc/nginx /etc/nginx.dist
fi

git clone --depth=1 -q https://github.com/h5bp/server-configs-nginx /etc/nginx
