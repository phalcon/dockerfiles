#
# PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/ubuntu:12.04.5

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Adding repositories
RUN apt-add-repository -y ppa:chris-lea/libsodium && \
    add-apt-repository -y ppa:gearman-developers/ppa && \
    LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php5-oldstable

RUN apt-get update -y && apt-get upgrade -y

# Install PHP
RUN apt-get install -y --force-yes \
    php-apc \
    php5-cli \
    php5-common \
    php5-curl \
    php5-dev \
    php5-gd \
    php-gettext \
    php5-gmp \
    php5-imagick \
    php5-imap \
    php5-intl \
    php5-memcached \
    php5-memcache \
    php5-mcrypt \
    php5-mhash \
    php5-mysql \
    php-pear \
    php5-odbc \
    php5-pgsql \
    php5-ps \
    php5-pspell \
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
    libyaml-dev

RUN pecl channel-update pecl.php.net && \
    export CFLAGS="-O1 -g3 -fno-strict-aliasing -std=gnu90" && \
    PHP_EXT_DIR=`php-config --extension-dir`

# Install ext-redis
ADD installers/redis.sh redis.sh
RUN bash redis.sh && rm redis.sh

# Install ext-mongo
ADD installers/mongo.sh mongo.sh
RUN bash mongo.sh && rm mongo.sh

# Install ext-gearman
ADD installers/gearman.sh gearman.sh
RUN bash gearman.sh && rm gearman.sh

# Install ext-aerospike
ADD installers/aerospike.sh aerospike.sh
RUN bash aerospike.sh && rm aerospike.sh

# Install ext-ssh2
ADD installers/ssh2.sh ssh2.sh
RUN bash ssh2.sh && rm ssh2.sh

# Install ext-pinba
ADD installers/pinba.sh pinba.sh
RUN bash pinba.sh && rm pinba.sh

# Install ext-handlersocketi
ADD installers/handlersocketi.sh handlersocketi.sh
RUN bash handlersocketi.sh && rm handlersocketi.sh

# Install ext-yaml
RUN printf "\n" | pecl install yaml && \
    echo 'extension=yaml.so' | tee /etc/php5/mods-available/yaml.ini && \
    ln -s /etc/php5/mods-available/yaml.ini /etc/php5/conf.d/

# Install ext-libsodium
RUN printf "\n" | pecl install -a libsodium && \
    echo 'extension=libsodium.so' | tee /etc/php5/mods-available/libsodium.ini && \
    ln -s /etc/php5/mods-available/libsodium.ini /etc/php5/conf.d/

# Install ext-igbinary
RUN printf "\n" | pecl install -a igbinary && \
    echo 'extension=igbinary.so' | tee /etc/php5/mods-available/igbinary.ini && \
    ln -s /etc/php5/mods-available/igbinary.ini /etc/php5/conf.d/

# Fix PHP warnongs
RUN find /etc/php5/mods-available/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# Tune up PHP CLI
RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php5/cli/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php5/cli/php.ini && \
    sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php5/cli/php.ini && \
    sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php5/cli/php.ini && \
    sed -i 's|display_errors =.*|display_errors = On|' /etc/php5/cli/php.ini && \
    sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php5/cli/php.ini && \
    sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php5/cli/php.ini && \
    sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php5/cli/php.ini

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
