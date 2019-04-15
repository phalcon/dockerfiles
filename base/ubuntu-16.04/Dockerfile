FROM phalconphp/bootstrap:ubuntu-16.04

LABEL description="Slimmed-down base image to use for production with crond and supervisord" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.base.ubuntu-16.04"

ENV SUPERVISOR_VERSION=4.0.1

RUN apt clean -y \
    && apt update -y \
    && apt upgrade -y \
    && apt install --no-install-recommends -yq \
        cron \
        curl \
        dnsutils \
        git \
        gnupg \
        iproute2 \
        jq \
        less \
        logrotate \
        lsb-release \
        net-tools \
        python-setuptools \
        swig \
        tmpreaper \
        unzip \
        wget \
    && cd /tmp \
    && curl -sSL \
        "https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz" \
        -o "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && tar -xzf "supervisor-${SUPERVISOR_VERSION}.tar.gz" \
    && cd "supervisor-${SUPERVISOR_VERSION}" \
    && python setup.py install --quiet \
    && mkdir -p /var/log/supervisor \
    && /usr/local/bin/supervisord --version \
    && sed -i "s/^[\s]*su root syslog/# su root syslog/g" /etc/logrotate.conf \
    && apt autoremove -y \
    && apt clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists \
       -not -name lock \
       -type f \
       -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done

# Please do not modify this line.
# This path is used in DockerHub Automated builds.
# For more see: https://github.com/docker/hub-feedback/issues/841
COPY ./base/ubuntu-16.04/configs /

CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
