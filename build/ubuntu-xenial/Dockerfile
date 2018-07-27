FROM phalconphp/bootstrap:ubuntu-16.04

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install -y \
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
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/lib/apt/lists -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
