#
# PHP 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/ubuntu:14.04.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Adding repositories
RUN apt-add-repository -y ppa:chris-lea/libsodium && \
    LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php5-5.6

RUN apt-get update -y && apt-get upgrade -y

# Install PHP
RUN apt-get install -y --force-yes \
    php-apc \
    php5-cli \
    php5-common \
    php5-curl \
    php5-dev \
    php5-gd \
    php5-gearman \
    php-gettext \
    php5-gmp \
    php5-imagick \
    php5-imap \
    php5-intl \
    php5-memcached \
    php5-memcache \
    php5-mcrypt \
    php5-mhash \
    php5-mongo \
    php5-mysql \
    php-pear \
    php5-odbc \
    php5-pgsql \
    php5-ps \
    php5-pspell \
    php5-redis \
    php5-readline \
    php5-recode \
    php5-sqlite \
    php5-tidy \
    php5-xmlrpc \
    php5-xsl \
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
    echo 'extension=ssh2.so' | tee /etc/php5/mods-available/ssh2.ini && \
    ln -s /etc/php5/mods-available/ssh2.ini /etc/php5/conf.d/20-ssh2.ini

# Install ext-yaml
RUN printf "\n" | pecl install yaml && \
    echo 'extension=yaml.so' | tee /etc/php5/mods-available/yaml.ini && \
    ln -s /etc/php5/mods-available/yaml.ini /etc/php5/cli/conf.d/20-yaml.ini

# Install ext-libsodium
RUN printf "\n" | pecl install -a libsodium && \
    echo 'extension=libsodium.so' | tee /etc/php5/mods-available/libsodium.ini && \
    ln -s /etc/php5/mods-available/libsodium.ini /etc/php5/cli/conf.d/20-libsodium.ini

# Install ext-igbinary
RUN printf "\n" | pecl install -a igbinary && \
    echo 'extension=igbinary.so' | tee /etc/php5/mods-available/igbinary.ini && \
    ln -s /etc/php5/mods-available/igbinary.ini /etc/php5/cli/conf.d/20-igbinary.ini

# Install ext-xdebug
RUN pecl install xdebug && \
    echo 'zend_extension=/usr/lib/php5/20131226/xdebug.so' | tee /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_enable=true" | tee -a /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_host=localhost" | tee -a /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_port=10000" | tee -a /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_handler=\"dbgp\"" | tee -a /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.remote_connect_back=1" | tee -a /etc/php5/mods-available/xdebug.ini && \
    echo "xdebug.cli_color=1" | tee -a /etc/php5/mods-available/xdebug.ini && \
    ln -sf /etc/php5/mods-available/xdebug.ini /etc/php5/cli/conf.d/20-xdebug.ini

# Fix PHP warnings
RUN find /etc/php5/mods-available/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Tune up PHP CLI
RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php5/cli/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php5/cli/php.ini && \
    sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php5/cli/php.ini && \
    sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php5/cli/php.ini && \
    sed -i 's|display_errors =.*|display_errors = On|' /etc/php5/cli/php.ini && \
    sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php5/cli/php.ini && \
    sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php5/cli/php.ini && \
    sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php5/cli/php.ini && \
    echo "apc.enable_cli = 1" | tee -a /etc/php5/mods-available/apcu.ini

# Cleanup package manager
RUN apt-get autoremove && \
    apt-get autoclean && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set workdir
WORKDIR /app

# Define mountable directories
VOLUME ["/app"]

# Set up the command arguments
ENTRYPOINT ["php"]
CMD ["-v"]
