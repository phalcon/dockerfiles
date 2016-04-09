#
# Base PHP Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM klay/ubuntu

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

ENV PHP_MEMORY_LIMIT 512M
ENV MAX_UPLOAD 50M
ENV PHP_MAX_FILE_UPLOAD 200
ENV PHP_MAX_POST 100M
ENV PHPENV_ROOT /usr/local/phpenv
ENV PHP_BUILD_EXTRA_MAKE_ARGUMENTS=' -j4'
ENV PATH "$PATH:$PHPENV_ROOT/bin:$PHPENV_ROOT/shims"

RUN apt-get update -y && apt-get upgrade -y

# Install dependencies
RUN apt-get install -y --no-install-recommends --force-yes \
    ca-certificates \
    g++ \
    bison \
    bzip2 \
    gnupg \
    libcurl4-openssl-dev \
    libreadline6-dev \
    librecode-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    librecode0 \
    libsqlite3-0 \
    libxml2 \
    libc-dev \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libtidy-dev \
    libxslt1-dev \
    file \
    devscripts \
    debhelper \
    pkg-config \
    php5-dev \
    xz-utils

RUN git clone https://github.com/madumlao/phpenv.git /usr/local/phpenv && \
    git clone https://github.com/php-build/php-build.git /root/php-build

RUN /root/php-build/install.sh && rm /root/php-build -rf

RUN echo '# phpenv setup' > /etc/profile.d/phpenv.sh && \
    echo 'export PHPENV_ROOT=/usr/local/phpenv' >> /etc/profile.d/phpenv.sh && \
    echo 'export PATH="$PHPENV_ROOT/bin:$PATH"' >> /etc/profile.d/phpenv.sh && \
    echo 'eval "$(phpenv init -)"' >> /etc/profile.d/phpenv.sh && \
    chmod +x /etc/profile.d/phpenv.sh

RUN phpenv install 5.4.45 && rm /tmp/* -rf && \
    phpenv install 5.5.34 && rm /tmp/* -rf && \
    phpenv install 5.6.20 && rm /tmp/* -rf && \
    phpenv install 7.0.5 && rm /tmp/* -rf

# Cleanup package manager
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set workdir
WORKDIR /app

# Define mountable directories
VOLUME ["/app"]

# Set up the command arguments
ENTRYPOINT ["phpenv"]
CMD ["--help"]
