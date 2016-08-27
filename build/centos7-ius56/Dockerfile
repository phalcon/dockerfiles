# Pull base image
FROM phalconphp/build:centos7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN /usr/local/bin/yum-upgrade \
    && curl -s https://setup.ius.io | bash \
    && /usr/local/bin/yum-install \
       dnf-plugins-core \
       yum-utils \
       php56u-cli \
       php56u-common \
       php56u-devel \
    && yum clean all
