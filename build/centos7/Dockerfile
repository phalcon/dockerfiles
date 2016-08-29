# Pull base image
FROM phalconphp/bootstrap:centos-7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV PATH=/usr/lib/ccache:$PATH

RUN /usr/local/bin/yum-upgrade \
    && /usr/local/bin/yum-install \
        autoconf \
        automake \
        binutils \
        bison \
        flex \
        gcc \
        gcc-c++ \
        gettext \
        dnf \
        dnf-plugins-core \
        yum-utils \
        libtool \
        re2c \
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
        gnupg \
        pygpgme \
        wget \
        ccache \
        cmake3 \
        readline-devel \
        libyaml-devel \
        binutils-devel \
        zlib-devel \
        doxygen \
        perl-Test-Harness \
    && wget -qO - https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh | bash \
    && wget -qO - https://packagecloud.io/install/repositories/phalcon/nightly/script.rpm.sh | bash \
    && sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers \
    && yum clean all
