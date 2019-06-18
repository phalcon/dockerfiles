FROM phalconphp/bootstrap:ubuntu-14.04

LABEL description="Docker images to build Phalcon on Ubuntu 14.04" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.trusty"

# A hack to prevent running udev triggers
COPY ./provision.d /
RUN chmod +x /usr/sbin/policy-rc.d \
    && dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

RUN apt-get clean -y \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -yq \
        alien \
        binutils-dev \
        ccache \
        cdbs \
        cmake \
        curl \
        debhelper \
        devscripts \
        doxygen \
        equivs \
        fakeroot \
        gdb \
        gdebi-core \
        git \
        gnupg \
        libpcre3-dev \
        libreadline-dev \
        libyaml-dev \
        re2c \
        rpm \
        sudo \
        wget \
        zlib1g-dev \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && wget -qO - https://packagecloud.io/phalcon/stable/gpgkey | apt-key add - \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
