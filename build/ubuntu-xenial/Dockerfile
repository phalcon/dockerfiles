# Pull base image
FROM ubuntu:xenial

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV LC_ALL="C.UTF-8" LANG="C.UTF-8"

# Install dependencies to speed up builds
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y \
    build-essential \
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
    doxygen \
    python-pip \
    python-dev \
    python-daemon \
    python-yaml \
    python-gevent \
    python-six \
    python-msgpack \
    python-sphinx \
    luajit \
    lua5.1 \
    liblua5.1-dev \
    lua5.2 \
    liblua5.2-dev \
    lua5.3 \
    liblua5.3-dev \
    dh-lua \
    apt-transport-https

RUN echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Cleanup package manager
RUN apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*