FROM centos:7

LABEL description="Bootstrap image to use for production with Ubuntu 12.04" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.bootstrap.centos-7"

ENV TIMEZONE=UTC \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TERM=xterm

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum upgrade -y \
    && yum -y install \
        epel-release \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
