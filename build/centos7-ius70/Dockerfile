FROM phalconphp/build:centos7

LABEL description="Docker images to build Phalcon on CentOS 7" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.centos7-ius70"

RUN yum upgrade -y \
    && curl -s https://setup.ius.io | bash \
    && yum -y install \
        php70u-cli \
        php70u-pdo \
        php70u-json \
        php70u-common \
        php70u-devel \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
