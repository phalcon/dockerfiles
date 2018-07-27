FROM ubuntu:18.04

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive

RUN set -e \
    && set -u \
    && apt update -y\
    && apt upgrade -y \
    && apt install -y \
        software-properties-common \
        lsb-release \
        ca-certificates \
        apt-transport-https \
        locales \
        tzdata \
    && echo "export TERM=xterm" >> /root/.bashrc \
    && locale-gen ${LANG} \
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" | tee /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-add-repository -y multiverse \
    && apt update -y \
    && apt install -y \
        python-minimal \
        python-setuptools \
        python-pip \
        python-paramiko \
        python-jinja2 \
        python-cffi \
        python-dev \
        libffi-dev \
        libssl-dev \
        build-essential \
    && pip install --upgrade pip \
    && hash -r \
    && pip install ansible \
    && chmod 750 /usr/local/bin/ansible* \
    && apt purge -y -f \
        python-dev \
        build-essential \
        libssl-dev \
        libffi-dev \
    && apt autoremove -y -f \
    && apt clean -y \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*
