# Pull base image
FROM phalconphp/bootstrap:centos-7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV PATH=/usr/lib/ccache:$PATH

RUN /usr/local/bin/yum-upgrade \
    && /usr/local/bin/yum-install autoconf \
    automake \
    binutils \
    bison \
    flex \
    gcc \
    gcc-c++ \
    gettext \
    libtool \
    make \
    patch \
    pkgconfig \
    redhat-rpm-config \
    rpm-build \
    rpm-sign \
    yum-utils \
    rpm-build \
    rpmdevtools \
    sudo \
    wget \
    git \
    ccache \
    cmake3 \
    readline-devel \
    libyaml-devel \
    binutils-devel \
    zlib-devel \
    doxygen \
    perl-Test-Harness \
    && sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers \
    && yum clean all
