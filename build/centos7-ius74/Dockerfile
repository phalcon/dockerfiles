FROM phalconphp/build:centos7

LABEL description="Docker images to build Phalcon on CentOS 7" \
      maintainer="Serghei Iakovlev <serghei@phalcon.io>" \
      vendor=Phalcon \
      name="com.phalconphp.images.build.centos7-ius74"

# This image has disabled `centos-sclo-rh-source' repo in the
# /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo
#
# The `yum-builddep' from `yum-utils' package, for some unknown to me
# reason, enable all source repos for corresponding binary repos.
#
# For example it enables `centos-sclo-rh-source'.  But in fact this repo
# has wrong base url and this lead to an error:
#
# http://vault.centos.org/centos/7/sclo/Source/rh/repodata/repomd.xml:
# [Errno 14] HTTP Error 404 - Not Found

RUN curl -s https://setup.ius.io | bash \
    && yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum install -y \
      yum-utils \
      centos-release-scl \
    && yum-config-manager --enable centos-sclo-sclo-testing \
    && yum -y install devtoolset-7-gcc \
    && echo "source /opt/rh/devtoolset-7/enable" | tee -a /etc/bashrc \
    && echo "source /opt/rh/devtoolset-7/enable" | tee -a /etc/profile \
    && source /opt/rh/devtoolset-7/enable \
    && gcc --version \
    && ln -sf /opt/rh/devtoolset-7/root/usr/bin/gcc /usr/bin/gcc \
    && awk \
        '/centos-sclo-rh-source/{f=1} f>6{f=0} f{f++; $0="# " $0} 1' \
        /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo > repo.patch \
    && mv repo.patch /etc/yum.repos.d/CentOS-SCLo-scl-rh.repo \
    && yum-config-manager --enable remi-php74 \
    && yum -y install \
        pcre-devel \
        php-cli \
        php-pdo \
        php-json \
        php-common \
        php-devel \
        php-pecl-psr \
        php-pecl-psr-devel \
    && for p in cli pdo json common devel; do yum info php-${p} | egrep "Name|Version" && echo; done \
    && yum clean all \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

