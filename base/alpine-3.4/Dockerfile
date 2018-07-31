FROM phalconphp/bootstrap:alpine-3.4

ENV GOSU_VERSION 1.10

LABEL description="Slimmed-down base image to use for production with Alpine 3.4 and supervisord" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.base.alpine-3.4"

RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache \
        bind-tools \
        curl \
        dcron \
        git \
        gnupg \
        iproute2 \
        jq \
        less \
        logrotate \
        net-tools \
        sudo \
        supervisor \
        swig \
        tar \
        unzip \
        vim \
        wget \
        xz \
    && mkdir -m 0644 -p /var/log/supervisor /var/log/cron /var/spool/cron/crontabs /etc/cron.d \
    && touch /var/log/cron/cron.log \
    && apk add --no-cache --virtual .gosu-deps dpkg \
    && export DPKG_ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$DPKG_ARCH" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$DPKG_ARCH.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && export GPG_KEY="B42F6819007F00F88E364FD4036A9C25BF357DD4" \
    && ( \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
        || gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" \
        || gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEY" \
        ) \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && apk del .gosu-deps \
    && rm -rf /tmp/* /var/cache/apk/* \
    && rm -f /usr/local/bin/gosu.asc \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

ADD configs /

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
