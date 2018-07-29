FROM phalconphp/bootstrap:ubuntu-12.04

LABEL description="Slimmed-down base image to use for production with Ubuntu 12.04 and supervisord" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.base"

RUN apt-get clean -y \
    && echo "deb http://archive.ubuntu.com/ubuntu/ precise-backports main restricted" >> /etc/apt/sources.list \
    && echo "deb-src http://archive.ubuntu.com/ubuntu/ precise-backports main restricted" >> /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -yq \
        cron \
        curl \
        dnsutils \
        git \
        gnupg \
        iproute \
        less \
        logrotate \
        lsb-release \
        net-tools \
        sudo \
        supervisor \
        swig \
        tmpreaper \
        unzip \
        vim \
        wget \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /var/log/supervisor \
    && wget --quiet -O /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
    && chmod a+x /usr/bin/jq \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/lib/apt/lists -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

ADD configs /

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
