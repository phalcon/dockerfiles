#
# phalconphp/bootstrap:alpine-3 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM alpine:3.4

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    TERM=xterm \
    USER=root \
    HOME="/root"

# Add base tools
ADD base.tar /

# Init bootstrap
RUN set -x \
    && chmod +x /usr/local/bin/* \
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
