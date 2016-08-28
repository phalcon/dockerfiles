# Pull base image
FROM phalconphp/build:centos7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN /usr/local/bin/yum-upgrade \
    && curl -s https://setup.ius.io | bash \
    && /usr/local/bin/yum-install \
       php55u-cli \
       php55u-common \
       php55u-devel \
    && yum clean all
