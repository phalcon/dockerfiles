#
# phalconphp/base:alpine-3 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/bootstrap:alpine-3

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

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
