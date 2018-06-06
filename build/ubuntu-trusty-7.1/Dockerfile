# Pull base image
FROM phalconphp/build:ubuntu-trusty

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && /usr/local/bin/apt-install \
       php7.1-dev \
       php7.1-common \
       php7.1-cli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
