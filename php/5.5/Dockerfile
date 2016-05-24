#
# PHP-CLI 5.5 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/ubuntu:14.04.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Adding repositories
RUN apt-add-repository -y ppa:chris-lea/libsodium && \
    LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php

RUN apt-get update -y && apt-get upgrade -y

# Install PHP
RUN apt-get install -y --force-yes  --no-install-recommends \
    php5.5-apcu \
    php5.5-bcmath \
    php5.5-bz2 \
    php5.5-cli \
    php5.5-common \
    php5.5-curl \
    php5.5-dba \
    php5.5-dev \
    php5.5-gd \
    php5.5-gearman \
    php5.5-gettext \
    php5.5-gmp \
    php5.5-imagick \
    php5.5-imap \
    php5.5-intl \
    php5.5-json \
    php5.5-mbstring \
    php5.5-memcached \
    php5.5-memcache \
    php5.5-mcrypt \
    php5.5-mongo \
    php5.5-mysql \
    php-pear \
    php5.5-odbc \
    php5.5-pgsql \
    php5.5-ps \
    php5.5-pspell \
    php5.5-redis \
    php5.5-readline \
    php5.5-recode \
    php5.5-soap \
    php5.5-sqlite3 \
    php5.5-tidy \
    php5.5-xdebug \
    php5.5-xmlrpc \
    php5.5-xsl \
    php5.5-zip \
    libcurl4-openssl-dev \
    libreadline6-dev \
    libgearman-dev \
    libevent-dev \
    librecode-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    librecode0 \
    libsodium-dev \
    libssh2-1-dev \
    libsqlite3-0 \
    libxml2 \
    libc-dev \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libmcrypt-dev \
    libtidy-dev \
    libxslt1-dev \
    libyaml-dev \
    libfreetype6-dev \
    libxpm-dev \
    libvpx-dev

RUN pecl channel-update pecl.php.net

# Install ext-aerospike
ADD installers/aerospike.sh aerospike.sh
RUN bash aerospike.sh && rm aerospike.sh

# Install ext-pinba
ADD installers/pinba.sh pinba.sh
RUN bash pinba.sh && rm pinba.sh

# Install ext-handlersocketi
ADD installers/handlersocketi.sh handlersocketi.sh
RUN bash handlersocketi.sh && rm handlersocketi.sh

# Install ext-ssh2
RUN printf "\n" | pecl install -a ssh2-0.12 && \
    echo 'extension=ssh2.so' | tee /etc/php/5.5/mods-available/ssh2.ini && \
    ln -s /etc/php/5.5/mods-available/ssh2.ini /etc/php/5.5/cli/conf.d/20-ssh2.ini

# Install ext-yaml
RUN printf "\n" | pecl install yaml && \
    echo 'extension=yaml.so' | tee /etc/php/5.5/mods-available/yaml.ini && \
    ln -s /etc/php/5.5/mods-available/yaml.ini /etc/php/5.5/cli/conf.d/20-yaml.ini

# Install ext-libsodium
RUN printf "\n" | pecl install -a libsodium && \
    echo 'extension=libsodium.so' | tee /etc/php/5.5/mods-available/libsodium.ini && \
    ln -s /etc/php/5.5/mods-available/libsodium.ini /etc/php/5.5/cli/conf.d/20-libsodium.ini

# Tune Up ext-xdebug
RUN echo 'zend_extension=/usr/lib/php/20121212/xdebug.so' | tee /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.remote_enable=true" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.remote_host=localhost" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.remote_port=10000" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.remote_handler=\"dbgp\"" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    echo "xdebug.cli_color=1" | tee -a /etc/php/5.5/mods-available/xdebug.ini && \
    ln -sf /etc/php/5.5/mods-available/xdebug.ini /etc/php/5.5/cli/conf.d/20-xdebug.ini

# Fix PHP warnings
RUN find /etc/php/5.5/mods-available/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Tune up PHP-CLI
RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/5.5/cli/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php/5.5/cli/php.ini && \
    sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php/5.5/cli/php.ini && \
    sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php/5.5/cli/php.ini && \
    sed -i 's|display_errors =.*|display_errors = On|' /etc/php/5.5/cli/php.ini && \
    sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php/5.5/cli/php.ini && \
    sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php/5.5/cli/php.ini && \
    sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php/5.5/cli/php.ini && \
    echo "apc.enable_cli = 1" | tee -a /etc/php/5.5/mods-available/apcu.ini

# Cleanup package manager
RUN apt-get autoremove && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php5 /etc/php/5.6 /etc/php/7.0 /usr/lib/php/5.6 /usr/lib/php/7.0 /usr/lib/php/20151012 /usr/lib/php/20131226

# Set workdir
WORKDIR /app

# Define mountable directories
VOLUME ["/app"]

# Set up the command arguments
ENTRYPOINT ["php"]
CMD ["-v"]
