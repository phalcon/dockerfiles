#
# Bootstrap Dockerfile for Ubuntu 14.02
#
# https://github.com/phalcon/dockerfiles
#

FROM ubuntu:12.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Bootstrap Dockerfile for Ubuntu 12.04\",\"License\":\"BSD\",\"Version\":\"0.1.0\",\"Layouts\":5}"

# Add base tools
ADD baselayout.tar /

# Init bootstrap (and install ansible)
RUN export DEBIAN_FRONTEND=noninteractive \
    && set -x \
    # Fix root terminal
    && echo "export TERM=xterm" >> /root/.bashrc \
    # Generate base locale
    && locale-gen ${LANG} \
    # Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    # Setup timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" | tee /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list \
    # System update
    && /usr/local/bin/apt-upgrade \
    # Install base stuff
    && /usr/local/bin/apt-install \
        apt-utils \
        software-properties-common \
        python-software-properties \
        lsb-release \
        ca-certificates \
        apt-transport-https \
    # Install ansible
    && /usr/local/bin/apt-install \
        python-minimal \
        python-setuptools \
        python-pip \
        python-paramiko \
        python-jinja2 \
        python-dev \
        libffi-dev \
        libssl-dev \
        build-essential \
    && pip install --upgrade pip \
    && hash -r \
    && pip install ansible \
    && chmod 750 /usr/local/bin/ansible* \
    # Cleanup
    && apt-get purge -y -f --force-yes \
        python-dev \
        build-essential \
        libssl-dev \
        libffi-dev \
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
