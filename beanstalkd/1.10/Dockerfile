#
# Beanstalkd Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/base:alpine-3

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV BEANSTALKD_VERSION="1.10"

RUN addgroup -S beanstalk \
    && adduser -S -G beanstalk beanstalk \
    && /usr/local/bin/apk-install 'su-exec>=0.2' \
    && /usr/local/bin/apk-install --virtual build-dependencies \
        gcc \
        make \
        musl-dev \
    && curl -sL https://github.com/kr/beanstalkd/archive/v$BEANSTALKD_VERSION.tar.gz | tar xvz -C /tmp \
    && cd /tmp/beanstalkd-$BEANSTALKD_VERSION \
    && sed -i "s|#include <sys/fcntl.h>|#include <fcntl.h>|g" sd-daemon.c \
    && make || return 1 \
    && make PREFIX=/usr install \
    && mkdir -p /var/lib/beanstalkd \
    && chown beanstalk:beanstalk /var/lib/beanstalkd \
    && /usr/local/bin/apk-delete build-dependencies \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# Expose ports
EXPOSE 11300

# Expose volumes
VOLUME ["/var/lib/beanstalkd"]

# Set up the command arguments
ENTRYPOINT ["beanstalkd", "-p", "11300", "-u", "beanstalk"]
CMD ["-b", "/var/lib/beanstalkd"]
