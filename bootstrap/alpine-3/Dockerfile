#
# Bootstrap Dockerfile for Alpine 3.4
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM alpine:3.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm \
    USER=root \
    HOME="/root"

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Bootstrap Dockerfile for Alpine 3.4\",\"License\":\"BSD\",\"Version\":\"1.0.0\"}"

# Add base tools
ADD base.tar /

# Init bootstrap
RUN set -x \
    && chmod +x /usr/local/bin/* \
    # Use dl-4, as the main repo is down
    && sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories \
    # Tune Up root terminal
    && echo '[ -z "\$PS1" ] && return' >> /root/.bashrc \
    && echo 'HISTCONTROL=ignoredups:ignorespace' >> /root/.bashrc \
    && echo 'shopt -s histappend' >> /root/.bashrc \
    && echo 'HISTSIZE=1000' >> /root/.bashrc \
    && echo 'HISTFILESIZE=2000' >> /root/.bashrc \
    && echo 'shopt -s checkwinsize' >> /root/.bashrc \
    && echo "export TERM=${TERM}" >> /root/.bashrc \
    # Add testing
    && echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    # System update
    && /usr/local/bin/apk-upgrade \
    # Install base stuff
    && /usr/local/bin/apk-install \
        bash \
        bash-completion \
        ca-certificates \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*
