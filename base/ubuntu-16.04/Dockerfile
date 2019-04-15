FROM phalconphp/bootstrap:ubuntu-16.04

LABEL description="Slimmed-down base image to use for production with Ubuntu 16.04 and supervisord" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.base.ubuntu-16.04"

ENV SUPERVISOR_VERSION=4.0.1

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
        wget

RUN cd /tmp \
    && curl -sSL \
        "https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz" \
        -o "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && tar -xzf "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && cd "supervisor-${SUPERVISOR_VERSION}" \
    && python setup.py install --quiet \
    && mkdir -p /var/log/supervisor \
    && /usr/local/bin/supervisord --version

RUN sed -i "s/^[\s]*su root syslog/# su root syslog/g" /etc/logrotate.conf \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists \
       -not -name lock \
       -type f \
       -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

ADD configs /

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
