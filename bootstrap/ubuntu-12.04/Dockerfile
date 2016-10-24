#
# Bootstrap Dockerfile for Ubuntu 12.04
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM ubuntu:12.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Bootstrap Dockerfile for Ubuntu 12.04\",\"License\":\"BSD\",\"Version\":\"1.0.1\"}"

# Add base tools
ADD base.tar /

# Init bootstrap
RUN export DEBIAN_FRONTEND=noninteractive \
    && set -x \
    # Add multiverse
    && echo "deb http://archive.ubuntu.com/ubuntu/ precise-security multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://archive.ubuntu.com/ubuntu/ precise-security multiverse" >> /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ precise multiverse" >> /etc/apt/sources.list \
    && echo "deb-src http://archive.ubuntu.com/ubuntu/ precise multiverse" >> /etc/apt/sources.list \
    # Fix root terminal
    && echo "export TERM=${TERM}" >> /root/.bashrc \
    # Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    # Generate base locale
    && locale-gen en_US ${LANG} \
    && dpkg-reconfigure locales \
    && update-locale LANG=${LANG} \
    # Setup timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && dpkg-reconfigure tzdata \
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
    # Cleanup
    && apt-get autoremove -y -f \
    && apt-get clean -y
