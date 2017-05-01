#
# Bootstrap Dockerfile for Debian 8
#
# https://github.com/phalcon/dockerfiles
#

FROM debian:8

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# Add base tools
ADD baselayout.tar /

# Init bootstrap (and install ansible)
RUN export DEBIAN_FRONTEND=noninteractive \
    && printf "LANGUAGE=\"en_US.UTF-8\"\nLC_ALL=\"en_US.UTF-8\"" >> /etc/environment \
    && set -x \
    # Fix root terminal
    && echo "export TERM=xterm" >> /root/.bashrc \
    # Enable non-free
    && sed -ri 's/(deb.*\/debian jessie main)/\1 contrib non-free /' -- /etc/apt/sources.list \
    # Setup timezone
    && ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" | tee /etc/timezone &> /dev/null \
    && dpkg-reconfigure --frontend=noninteractive tzdata \
    # System update
    && /usr/local/bin/apt-upgrade \
    # Install locales
    && /usr/local/bin/apt-install locales \
    # Setup base locale
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=${LANG} \
    # Install base stuff
    && /usr/local/bin/apt-install \
        software-properties-common \
        lsb-release \
        locales \
        ca-certificates \
        apt-transport-https \
    # Install ansible
    && /usr/local/bin/apt-install \
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
    # Cleanup
    && apt-get purge -y -f --force-yes \
        python-dev \
        build-essential \
        libssl-dev \
        libffi-dev \
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
