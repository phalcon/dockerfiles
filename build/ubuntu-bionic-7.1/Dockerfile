FROM phalconphp/build:ubuntu-bionic

LABEL description="Docker images to build Phalcon on Ubuntu 18.04" \
      maintainer="Serghei Iakovlev <serghei@phalcon.io>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.bionic-7.1"

RUN apt-get update \
    && apt-get install --no-install-recommends -yq \
        php7.1-dev \
        php7.1-common \
        php7.1-cli \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
