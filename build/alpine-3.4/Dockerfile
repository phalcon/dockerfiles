FROM phalconphp/bootstrap:alpine-3.4

LABEL description="Docker images to build Phalcon on Alpine 3.4" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.alpine-3.4"

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache \
        alpine-sdk \
        ccache \
        cmake \
        curl \
        gdb \
        geoip-dev \
        jansson-dev \
        openssl-dev \
        pcre-dev \
        re2c \
        su-exec \
        sudo \
        tar \
        wget \
        xz \
        yaml-dev \
        zlib-dev \
    && sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers \
	&& rm -rf /tmp/* /var/cache/apk/* \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
