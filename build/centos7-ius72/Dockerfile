FROM phalconphp/build:centos7

LABEL description="Docker images to build Phalcon on CentOS 7" \
    maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
    vendor=Phalcon \
    name="com.phalconphp.images.build.centos7-ius72"

RUN yum upgrade -y \
    && curl -s https://setup.ius.io | bash \
    && yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum install -y \
      yum-utils \
      centos-release-scl \
    && yum -y --enablerepo=centos-sclo-rh-testing install devtoolset-7-gcc \
    && echo "source /opt/rh/devtoolset-7/enable" | tee -a /etc/bashrc \
    && echo "source /opt/rh/devtoolset-7/enable" | tee -a /etc/profile \
    && source /opt/rh/devtoolset-7/enable \
    && gcc --version \
    && ln -sf /opt/rh/devtoolset-7/root/usr/bin/gcc /usr/bin/gcc \
    && yum-config-manager --enable remi-php72 \
    && yum -y install \
        php72u-cli \
        php72u-pdo \
        php72u-json \
        php72u-common \
        php72u-devel \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done
