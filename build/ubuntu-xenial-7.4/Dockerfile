FROM phalconphp/build:ubuntu-xenial

LABEL description="Docker images to build Phalcon on Ubuntu 16.04" \
      maintainer="Serghei Iakovlev <serghei@phalcon.io>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.xenial-7.4"

RUN LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && apt-get clean -y \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends -yq \
        php7.4-dev \
        php7.4-common \
        php7.4-cli \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && echo "Patching dpkg... " \
    && echo "See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=856396 " \
    && sed -i "s/|| 'gcc';/|| 'cc';/g" /usr/share/perl5/Dpkg/Arch.pm \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
