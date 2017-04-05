# Pull base image
FROM phalconphp/build:centos7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN /usr/local/bin/yum-upgrade \
    && curl -s https://setup.ius.io | bash \
    && /usr/local/bin/yum-install \
        php71u-cli \
        php71u-pdo \
        php71u-json \
        php71u-common \
        php71u-devel \
    && yum clean all
