# Pull base image
FROM phalconphp/build:debian-jessie

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && /usr/local/bin/apt-install \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget -qO - https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && /usr/local/bin/apt-upgrade \
       php7.0-dev \
       php7.0-common \
       php7.0-cli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
