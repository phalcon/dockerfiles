FROM phalconphp/build:debian-stretch

LABEL description="Docker image to build Phalcon on Debian Stretch" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.stretch-7.3"

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install --no-install-recommends -yq \
        php7.3-dev \
        php7.3-common \
        php7.3-cli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
