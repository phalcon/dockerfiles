FROM debian:bullseye

LABEL description="Bootstrap image to use for production with Debian Buster" \
      maintainer="Serghei Iakovlev <serghei@phalconphp.com>" \
      vendor=Phalcon \
      name="com.phalconphp.images.bootstrap.bullseye"

ENV TIMEZONE=UTC \
    LANGUAGE=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm

RUN apt-get clean -y \
    && sed -ri 's/(deb.*\/debian bullseye main)/\1 contrib non-free /' -- /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y locales \
    && export LANGUAGE=${LANGUAGE} \
    && export LANG=${LANG} \
    && export LC_ALL=${LC_ALL} \
    && locale-gen ${LANG} \
    && dpkg-reconfigure --frontend noninteractive locales \
    && apt-get install --no-install-recommends -yq \
        apt-transport-https \
        apt-utils \
        ca-certificates \
        lsb-release \
        software-properties-common \
        tzdata \
        locales \
    && printf "LANGUAGE=\"en_US.UTF-8\"\nLC_ALL=\"en_US.UTF-8\"" >> /etc/environment \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && echo 'LANG="en_US.UTF-8"' > /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=${LANG} \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /tmp/* /var/tmp/* \
    && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
    && find /var/cache -type f -delete \
    && find /var/log -type f | while read f; do echo -n '' > ${f}; done