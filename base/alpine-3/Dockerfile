#
# Base Dockerfile for Alpine 3.4
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/bootstrap:alpine-3

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Base Dockerfile for Alpine 3.4\",\"License\":\"BSD\",\"Version\":\"1.0.1\"}"

RUN \
    # Install base stuff
    /usr/local/bin/apk-install \
        curl \
        git \
        gnupg \
        net-tools \
        sudo \
        tar \
        wget \
        xz \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# Define working directory
WORKDIR /root

# Define default command
CMD ["/bin/bash"]
