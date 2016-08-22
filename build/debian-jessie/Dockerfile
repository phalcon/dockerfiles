# Pull base image
FROM phalconphp/bootstrap:debian-8

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" LC_ALL="C.UTF-8" LANG="C.UTF-8"

ADD backports.list /etc/apt/sources.list.d/
ADD preferences /etc/apt/preferences

RUN apt-get update && \
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
    doxygen  && \
    curl -L https://packagecloud.io/phalcon/stable/gpgkey | apt-key add - && \
    curl -L https://packagecloud.io/phalcon/nightly/gpgkey | apt-key add -

RUN echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Cleanup package manager
RUN apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
