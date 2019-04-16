FROM phalconphp/bootstrap:ubuntu-16.04

LABEL description="Slimmed-down base image to use for production with crond and supervisord" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.base.ubuntu-16.04"

ENV SUPERVISOR_VERSION=4.0.1
ENV GOSU_VERSION=1.11

RUN apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install --no-install-recommends -yq \
        cron \
        curl \
        dnsutils \
        git \
        gnupg \
        iproute2 \
        jq \
        less \
        logrotate \
        lsb-release \
        net-tools \
        python-setuptools \
        swig \
        tmpreaper \
        unzip \
        wget \
    && cd /tmp \
    && wget -O "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
        "https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz" \
    && tar -xzf "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && cd "supervisor-${SUPERVISOR_VERSION}" \
    && python setup.py install --quiet \
    && mkdir -p /var/log/supervisor \
    && /usr/local/bin/supervisord --version \
    && sed -i "s/^[\s]*su root syslog/# su root syslog/g" /etc/logrotate.conf \
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
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && rm /usr/local/bin/gosu.asc \
    && find /var/cache/apt/archives /var/lib/apt/lists \
       -not -name lock \
       -type f \
       -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

COPY ./configs /

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
