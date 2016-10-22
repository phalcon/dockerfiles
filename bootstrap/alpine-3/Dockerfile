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
    TERM=xterm

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Bootstrap Dockerfile for Alpine 3.4\",\"License\":\"BSD\",\"Version\":\"1.0.0\"}"

# Add base tools
ADD base.tar /

# Init bootstrap
RUN set -x \
    # Fix root terminal
    && echo "export TERM=${TERM}" >> /root/.bashrc \
    # Add testing
    && echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
    # System update
    && /usr/local/bin/apk-upgrade \
    # Install base stuff
    && /usr/local/bin/apk-install \
        bash \
        bash-completion \
        ca-certificates
