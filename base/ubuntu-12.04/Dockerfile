#
# Base Dockerfile for Ubuntu 12.04
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/bootstrap:ubuntu-12.04

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN \
    # Install base stuff
    /usr/local/bin/apt-install \
        curl \
        git \
        gnupg \
        net-tools \
        sudo \
        wget \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    # Cleanup
    && apt-get autoremove -y -f \
    && apt-get clean -y

# Define working directory
WORKDIR /root

# Define default command
CMD ["/bin/bash"]
