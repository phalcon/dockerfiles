# Pull base image
FROM phalconphp/build:debian-jessie

LABEL description="Docker images to build Phalcon on Debian Jessie" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.jessie-7.0"

RUN apt-get clean -y \
    && /usr/local/bin/apt-upgrade \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget -qO - https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && /usr/local/bin/apt-install \
       php7.0-dev \
       php7.0-common \
       php7.0-cli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done