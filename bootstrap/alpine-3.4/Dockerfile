FROM alpine:3.4

LABEL description="Bootstrap image to use for production with Alpine 3.4" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.bootstrap.alpine-3.4"

ENV TIMEZONE=UTC \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache \
        bash \
        bash-completion \
        ca-certificates \
        coreutils \
        musl-utils \
        tzdata \
        openssl \
    && update-ca-certificates 2>/dev/null || true \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" | tee /etc/timezone \
    && rm -rf /tmp/* /var/cache/apk/* \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
