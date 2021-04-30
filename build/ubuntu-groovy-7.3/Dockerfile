FROM phalconphp/build:ubuntu-groovy

LABEL description="Docker images to build Phalcon on Ubuntu 20.04" \
      maintainer="Serghei Iakovlev <serghei@phalcon.io>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.groovy-7.3"

RUN apt-get update \
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
