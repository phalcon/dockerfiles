FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive \
    TERM="xterm" \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

LABEL description="Base application image with Ubuntu 16.04" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name=base

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        apt-utils \
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
        re2c \
        software-properties-common \
        sudo \
        supervisor \
        swig \
        tmpreaper \
        unzip \
        vim \
        wget \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /var/log/supervisor \
    && curl -sSL https://github.com/webdevops/go-replace/releases/download/1.1.2/gr-64-linux -o /usr/local/bin/go-replace \
    && chmod +x /usr/local/bin/go-replace \
    && /usr/local/bin/go-replace --regex -s '^[\s]*su root syslog' -r "# su root syslog" /etc/logrotate.conf \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/*

ADD configs /

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]