FROM phalconphp/bootstrap:centos-7

LABEL description="Docker images to build Phalcon on CentOS 7" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.centos7"

ENV PATH=/usr/lib/ccache:$PATH

RUN yum upgrade -y \
    && yum -y install \
        autoconf \
        automake \
        binutils \
        binutils-devel \
        bison \
        ccache \
        cmake3 \
        dnf \
        dnf-plugins-core \
        doxygen \
        flex \
        gcc \
        gcc-c++ \
        gettext \
        git \
        gnupg \
        libtool \
        libyaml-devel \
        make \
        patch \
        perl-Test-Harness \
        pkgconfig \
        pygpgme \
        re2c \
        readline-devel \
        redhat-rpm-config \
        rpm-build \
        rpm-build \
        rpm-sign \
        rpmdevtools \
        scl-utils \
        scl-utils-build \
        sudo \
        wget \
        wget \
        yum-utils \
        yum-utils \
        zlib-devel \
    && wget -qO - https://packagecloud.io/install/repositories/phalcon/stable/script.rpm.sh | bash \
    && sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
