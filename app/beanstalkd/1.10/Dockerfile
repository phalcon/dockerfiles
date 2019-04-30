FROM phalconphp/base:alpine-3

LABEL description="Minimal beanstalkd image based on Alpine Linux" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.beanstalkd-1.10"

ENV BEANSTALKD_VERSION="1.10" \
    BEANSTALKD_PORT="11300" \
    BEANSTALKD_JOB_SIZE="65536" \
    BEANSTALKD_LIB="/var/lib/beanstalkd"

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        make \
        musl-dev \
    && cd /tmp \
    && wget --quiet -O "beanstalkd-${BEANSTALKD_VERSION}.tar.gz" \
        "https://github.com/kr/beanstalkd/archive/v${BEANSTALKD_VERSION}.tar.gz" \
    && tar -xzf "beanstalkd-${BEANSTALKD_VERSION}.tar.gz" \
    && cd "beanstalkd-${BEANSTALKD_VERSION}" \
    && sed -i "s|#include <sys/fcntl.h>|#include <fcntl.h>|g" sd-daemon.c \
    && make || return 1 \
    && make PREFIX=/usr install \
    && mkdir -p $BEANSTALKD_LIB \
    && beanstalkd -v

# cleanup
RUN apk del .build-deps \
    && rm -rf /tmp/* /var/cache/apk/* \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

COPY ./configs /

EXPOSE $BEANSTALKD_PORT

VOLUME [$BEANSTALKD_LIB]
