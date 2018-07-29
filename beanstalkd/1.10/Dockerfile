FROM phalconphp/base:alpine-3.4

LABEL description="Minimal beanstalkd image based on Alpine Linux" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.beanstalkd-1.10"

ENV BEANSTALKD_VERSION="1.10" \
    BEANSTALKD_PORT="11300" \
    BEANSTALKD_JOB_SIZE="65536"

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        make \
        musl-dev \
    && curl -sL https://github.com/kr/beanstalkd/archive/v$BEANSTALKD_VERSION.tar.gz | tar xvz -C /tmp \
    && cd /tmp/beanstalkd-$BEANSTALKD_VERSION \
    && sed -i "s|#include <sys/fcntl.h>|#include <fcntl.h>|g" sd-daemon.c \
    && make || return 1 \
    && make PREFIX=/usr install \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/cache/apk/* \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

ADD configs /

EXPOSE $BEANSTALKD_PORT

VOLUME ["/var/lib/beanstalkd"]
