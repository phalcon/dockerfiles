#
# PHP-CLI 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/base:ubuntu-12.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Base Dockerfile for Ubuntu 12.04\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":8}"

# Add installers
ADD installers.tar /

RUN \
    # Adding repositories
    add-apt-repository -y ppa:gearman-developers/ppa \
    && apt-add-repository -y ppa:chris-lea/libsodium \
    && LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php5-oldstable \
    # System update
    && /usr/local/bin/apt-upgrade \
    # Install base stuff
    && /usr/local/bin/apt-install \
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
        build-essential \
        make \
        re2c \
        libgearman-dev \
        libsodium-dev \
        libssh2-1-dev \
        libyaml-dev \
    && pecl channel-update pecl.php.net || exit 1 \
    # Install aerospike
    && bash /installers/aerospike.sh \
    # Install gearman
    && bash /installers/gearman.sh \
    # Install handlersocketi
    && bash /installers/handlersocketi.sh \
    # Install igbinary
    && bash /installers/igbinary.sh \
    # Install libsodium
    && bash /installers/libsodium.sh \
    # Install mongo
    && bash /installers/mongo.sh \
    # Install msgpack
    && bash /installers/msgpack.sh \
    # Install phalcon
    && bash /installers/phalcon.sh \
    # Install pinba
    && bash /installers/pinba.sh \
    # Install redis
    && bash /installers/redis.sh \
    # Install ssh2
    && bash /installers/ssh2.sh \
    # Install yaml
    && bash /installers/yaml.sh \
    # Install xdebug
    && bash /installers/xdebug.sh \
    # Tune up PHP-CLI
    && bash /installers/php.sh \
    # Cleanup
    && apt-get purge -y -f \
        build-essential \
        make \
        re2c \
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf /tmp/* /installers \
    # Create symlink
    && mkdir -p /etc/php \
    && ln -sf /etc/php5 /etc/php/5.4

# Set workdir
WORKDIR /app

# Define mountable directories
VOLUME ["/app"]

# Set up the command arguments
ENTRYPOINT ["php"]
CMD ["-v"]
