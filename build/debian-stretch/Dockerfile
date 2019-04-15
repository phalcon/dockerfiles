# Pull base image
FROM phalconphp/bootstrap:debian-9

LABEL description="Docker images to build Phalcon on Debian Stretch" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.stretch"

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

RUN apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && /usr/local/bin/apt-install \
        build-essential \
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
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
