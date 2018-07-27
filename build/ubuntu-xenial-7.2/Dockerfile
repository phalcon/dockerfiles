FROM phalconphp/build:ubuntu-xenial

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install -y \
        php7.2-dev \
        php7.2-common \
        php7.2-cli \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/lib/apt/lists -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
