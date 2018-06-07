# Pull base image
FROM phalconphp/build:centos7

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

RUN /usr/local/bin/yum-upgrade \
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
    # make this better
    && ln -sf /opt/rh/devtoolset-7/root/usr/bin/gcc /usr/bin/gcc \
    && yum-config-manager --enable remi-php72 \
    && /usr/local/bin/yum-install \
        php-cli \
        php-pdo \
        php-json \
        php-common \
        php-devel \
    && yum clean all
