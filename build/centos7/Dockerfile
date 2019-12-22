FROM phalconphp/bootstrap:centos-7

LABEL description="Docker images to build Phalcon on CentOS 7" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.centos7"

RUN yum upgrade -y \
    && yum -y install \
        autoconf \
        automake \
        binutils \
        binutils-devel \
        dnf \
        dnf-plugins-core \
        git \
        gnupg \
        libtool \
        make \
        patch \
        perl-Test-Harness \
        pkgconfig \
        pygpgme \
        re2c \
        redhat-rpm-config \
        rpm-build \
        rpm-sign \
        rpmdevtools \
        scl-utils \
        scl-utils-build \
        sudo \
        wget \
        yum-utils \
        zlib-devel \
    && sed -i.bak -n -e '/^Defaults.*requiretty/ { s/^/# /;};/^%wheel.*ALL$/ { s/^/# / ;} ;/^#.*wheel.*NOPASSWD/ { s/^#[ ]*//;};p' /etc/sudoers \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
