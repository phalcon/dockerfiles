#
# Bootstrap Dockerfile for CentOS 7
#
# https://github.com/phalcon/dockerfiles
#

FROM centos:7

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

# Set environment variables
ENV TIMEZONE=UTC \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon\ Framework \
    com.phalconphp.image-specs="{\"Description\":\"Bootstrap Dockerfile for CentOS 7\",\"License\":\"BSD\",\"Version\":\"0.1.0\",\"Layouts\":5}"

# Add base tools
ADD baselayout.tar /

# Init bootstrap (and install ansible)
RUN set -x \
    # Fix root terminal
    && echo "export TERM=xterm" >> /root/.bashrc \
    # System update
    && rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && /usr/local/bin/yum-upgrade \
    # Install ansible
    && /usr/local/bin/yum-install \
        epel-release \
        PyYAML \
        python-jinja2 \
        python-httplib2 \
        python-keyczar \
        python-paramiko \
        python-setuptools \
        python-setuptools-devel \
        libffi \
        python-devel \
        libffi-devel \
    && easy_install pip \
    && pip install --upgrade pip \
    && hash -r \
    && pip install ansible \
    && chmod 750 /usr/bin/ansible* \
    && yum erase -y python-devel \
    && yum clean all
