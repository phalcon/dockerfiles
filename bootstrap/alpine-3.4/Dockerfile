FROM alpine:3.4

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV TIMEZONE=UTC \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm \
    GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc \
    GLIBC_VERSION=2.27-r0

RUN echo http://dl-4.alpinelinux.org/alpine/v3.4/community/ >> /etc/apk/repositories \
    && apk update \
    && apk upgrade --force \
    && apk add --update --no-cache \
        bash \
        bash-completion \
        ca-certificates \
        tzdata \
        openssl \
    && apk add --no-cache --virtual .build-deps \
        curl \
        musl-dev \
    && for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done \
    && apk add --allow-untrusted /tmp/*.apk \
    && ( /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 -i en_US en_US.UTF-8 || true ) \
    && find /usr/glibc-compat/bin -type f -exec sh -c '[ -f /usr/bin/$(basename $1) ] || ln -s $1 /usr/bin/$(basename $1)' find-sh {} \; \
    && update-ca-certificates \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" | tee /etc/timezone \
    && apk del .build-deps \
    && rm -rf /tmp/* /var/cache/apk/* \
    && unset GLIBC_REPO GLIBC_VERSION \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
