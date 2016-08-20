# Pull base image
FROM phalconphp/bootstrap:ubuntu-15.10

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" LC_ALL="C.UTF-8" LANG="C.UTF-8"

# Install dependencies to speed up builds
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    gdb \
    git \
    ccache \
    devscripts \
    debhelper \
    fakeroot \
    cdbs \
    equivs \
    rpm \
    alien \
    sudo \
    cmake \
    libreadline-dev \
    libyaml-dev \
    binutils-dev \
    zlib1g-dev \
    doxygen && \
    echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Cleanup package manager
RUN apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
