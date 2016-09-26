#
# Base Dockerfile for Ubuntu 12.04
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/bootstrap:ubuntu-12.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Base Dockerfile for Ubuntu 12.04\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":5}"

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
