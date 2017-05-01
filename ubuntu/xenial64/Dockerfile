#
# Ubuntu 14.04.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Install base stuff
RUN apt -y update \
    # System update
    && apt -y upgrade \
    && apt -y install \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        curl \
        locales \
        lsb-release \
        openssh-server \
        software-properties-common \
        sudo \
        tzdata \
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
    && apt-add-repository multiverse \
   # Cleanup
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*