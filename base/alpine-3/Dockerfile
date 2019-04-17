FROM phalconphp/bootstrap:alpine-3

LABEL description="Slimmed-down base image to use for production with crond and supervisord" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.base.alpine-3"

ENV SUPERVISOR_VERSION=4.0.1 \
    GOSU_VERSION=1.11

# install base packages
RUN apk update \
    && apk upgrade --force \
    && apk add --no-cache \
        dcron \
        logrotate \
        tar \
        wget \
        xz \
    && cd /tmp \
    && apk add --no-cache --virtual .build-deps dpkg py-setuptools gnupg \
    && wget --quiet -O "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
        "https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz" \
    && tar -xzf "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && cd "supervisor-${SUPERVISOR_VERSION}" \
    && python setup.py install --quiet \
    && mkdir -p /var/log/supervisor \
    && /usr/bin/supervisord --version \
    && mkdir -m 0644 -p /var/log/supervisor /var/log/cron /var/spool/cron/crontabs /etc/cron.d \
    && touch /var/log/cron/cron.log \
    && export DPKG_ARCH="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget --quiet -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$DPKG_ARCH" \
    && wget --quiet -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$DPKG_ARCH.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && export GPG_KEY="B42F6819007F00F88E364FD4036A9C25BF357DD4" \
    && ( \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
        || gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEY" \
        || gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEY" \
        ) \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

# cleanup
RUN apk del .build-deps \
    && rm -rf /tmp/* /var/cache/apk/* \
    && rm -f /usr/local/bin/gosu.asc \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

COPY ./configs /

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
