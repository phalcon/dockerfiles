# Pull base image
FROM phalconphp/build:centos7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN /usr/local/bin/yum-upgrade \
    && curl -s https://setup.ius.io | bash \
    && /usr/local/bin/yum-install \
       php70u-cli \
       php70u-common \
       php70u-devel \
    && yum clean all
