#
# Dockerfile for phalconphp/php-apache:ubuntu-16.04
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM webdevops/php-apache:ubuntu-16.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"PHP 7.0 and Apache for Ubuntu 16.04\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":16}"

RUN \
    # Adding repositories
    curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    # Install base stuff
    && /usr/local/bin/apt-install \
        php7.0-phalcon \
        libapache2-mod-php7.0 \
    && a2enmod php7.0 rewrite
