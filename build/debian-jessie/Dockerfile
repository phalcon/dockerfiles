FROM phalconphp/bootstrap:debian-8

LABEL description="Docker image to build Phalcon for Debian Jessie" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.jessie"

ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

RUN apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && /usr/local/bin/apt-install \
        build-essential \
        curl \
        gdb \
        gnupg \
        wget \
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
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && wget -qO - https://packagecloud.io/phalcon/stable/gpgkey | apt-key add - \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
