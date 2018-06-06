# Pull base image
FROM phalconphp/build:centos7

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN /usr/local/bin/yum-upgrade \
    && curl -s https://setup.ius.io | bash \
    && /usr/local/bin/yum-install \
        php56u-cli \
        php56u-pdo \
        php56u-common \
        php56u-devel \
    && yum clean all
