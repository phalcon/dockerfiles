FROM phalconphp/build:ubuntu-trusty

LABEL description="Docker images to build Phalcon on Ubuntu 14.04" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.trusty-7.0"

ONBUILD RUN echo "Ubuntu 14.04 is no longer supported by ppa:ondrej/php maintainers"

RUN LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt-get clean -y \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -yq \
        php7.0-dev \
        php7.0-common \
        php7.0-cli \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
