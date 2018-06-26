FROM ubuntu:14.04

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV TIMEZONE UTC

# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Setup timezone
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" | tee /etc/timezone &&  \
    dpkg-reconfigure --frontend noninteractive tzdata

# Seup locale
RUN echo " \n\
LC_CTYPE=en_US.UTF-8 \n\
LC_ALL=en_US.UTF-8 \n\
LANG=en_US.UTF-8 \n\
LANGUAGE=en_US.UTF-8 \n\
" >> /etc/environment

RUN \
  locale-gen en_US en_US.UTF-8 && \
  dpkg-reconfigure locales && \
  export LANGUAGE=en_US.UTF-8 && \
  export LANG=en_US.UTF-8 && \
  export LC_ALL=en_US.UTF-8

RUN apt-get update -qq && apt-get upgrade -y

# Install dependencies
RUN apt-get install -yq --no-install-suggests --no-install-recommends --force-yes \
    autoconf \
    build-essential \
    ca-certificates \
    curl \
    bison \
    bzip2 \
    devscripts \
    debhelper \
    dnsutils \
    dos2unix \
    file \
    g++ \
    gcc \
    gdb \
    gettext \
    git \
    gnupg \
    grc \
    htop \
    inotify-tools \
    libpcre3 \
    libpcre3-dev \
    libssl-dev \
    lsb-base \
    lsb-core \
    lsb-release \
    lsb-security \
    make \
    man \
    mc \
    nano \
    openssh-client \
    pkg-config \
    pwgen \
    python-setuptools \
    python-software-properties \
    re2c \
    software-properties-common \
    ssh-client \
    ssl-cert \
    telnet \
    unzip \
    vim \
    wget \
    whois \
    xz-utils \
    zip

# Enable syntax highlighting in nano
RUN cd ~ && git clone https://github.com/nanorc/nanorc.git && \
    cd ~/nanorc && \
    make install && \
    echo 'include ~/.nano/syntax/ALL.nanorc' | tee -a ~/.nanorc && \
    cd ~ && \
    rm -rf ~/nanorc

# Cleanup package manager
RUN apt-get autoremove && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define working directory
WORKDIR /root

# Define default command
CMD ["/bin/bash"]
