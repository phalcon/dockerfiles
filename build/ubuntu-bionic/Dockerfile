FROM phalconphp/bootstrap:ubuntu-18.04

LABEL description="Docker images to build Phalcon on Ubuntu 18.04" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.bionic"

RUN LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install --no-install-recommends -yq \
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
        php7.0-common \
        php7.0-dev \
        php7.0-json \
        re2c \
        rpm \
        sudo \
        wget \
        zlib1g-dev \
    && echo '%adm ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && wget -qO - https://packagecloud.io/phalcon/stable/gpgkey | apt-key add - \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
