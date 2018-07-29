FROM phalconphp/build:ubuntu-bionic

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN apt purge -y \
        php7.0-common \
        php7.0-dev \
        php7.0-json \
    && apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install --no-install-recommends -yq \
        php7.1-common \
        php7.1-dev \
        php7.1-cli \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* /etc/php/7.0 \
    && find /var/lib/apt/lists -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
