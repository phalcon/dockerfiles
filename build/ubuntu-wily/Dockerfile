# Pull base image
FROM phalconphp/bootstrap:ubuntu-15.10

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

# Set environment variables
ENV DEBIAN_FRONTEND="noninteractive" \
    LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

RUN apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && /usr/local/bin/apt-install \
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
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
