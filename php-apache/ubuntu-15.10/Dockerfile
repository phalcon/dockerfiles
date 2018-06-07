#
# Dockerfile for phalconphp/php-apache:ubuntu-15.10
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM webdevops/php-apache-dev:ubuntu-15.10

LABEL maintainer="Serghei Iakovlev <serghei@phalconphp.com>"

# To override this run: docker run -e
ENV COMPOSER_HOME=/root/composer \
    PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1 \
    APPLICATION_PATH="/project"

# Add installers
ADD installers.tar /

RUN mkdir -p $APPLICATION_PATH/public \
    # These vars need to be exported twice
    && export DEBIAN_FRONTEND=noninteractive \
       COMPOSER_HOME=/root/composer \
       PATH=/root/composer/vendor/bin:$PATH \
       COMPOSER_ALLOW_SUPERUSER=1 \
    && chown -R $APPLICATION_USER:$APPLICATION_GROUP $APPLICATION_PATH \
    # Adding repositories
    && curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    && apt-add-repository ppa:ondrej/apache2 \
    && LC_ALL=en_US.UTF-8 apt-add-repository -y ppa:ondrej/php \
    # Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    # Update apt cache
    && apt-get update -y

# Install base stuff
RUN apt-get -o Dpkg::Options::="--force-confnew" install -y -f --no-install-recommends \
        php5-apcu \
        php5-dev \
        php5-gearman \
        php5-gmp \
        php5-igbinary \
        php5-imagick \
        php5-imap \
        php5-memcache \
        php5-mongo \
        php5-msgpack \
        php-pear \
        php5-odbc \
        php5-pgsql \
        php5-phalcon \
        php5-pspell \
        php5-recode \
        php5-ssh2 \
        php5-tidy \
        lsb-release \
        libssh2-1-dev \
        libyaml-dev \
        build-essential \
        make \
        re2c

    # Getting phive
RUN wget https://phar.io/releases/phive.phar \
    && wget https://phar.io/releases/phive.phar.asc \
    && gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 0x9B2D5D79 \
    && gpg --verify phive.phar.asc phive.phar \
    && chmod +x phive.phar \
    && mv phive.phar /usr/bin/phive \
    && pecl channel-update pecl.php.net \
    # Getting phpcs
    && curl -sOL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x phpcs.phar \
    && mv phpcs.phar /usr/local/bin/phpcs \
    # Getting phpcbf
    && curl -sOL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
    && chmod +x phpcbf.phar \
    && mv phpcbf.phar /usr/local/bin/phpcbf \
    # Getting phpmd
    && curl -sOL http://static.phpmd.org/php/latest/phpmd.phar \
    && chmod +x phpmd.phar \
    && mv phpmd.phar /usr/local/bin/phpmd \
    # Getting phing
    && curl -sOL http://www.phing.info/get/phing-latest.phar \
    && chmod +x phing-latest.phar \
    && mv phing-latest.phar /usr/local/bin/phing \
    # Install aerospike
    && bash /installers/aerospike.sh \
    # Install handlersocketi
    && bash /installers/handlersocketi.sh \
    # Install Weakref
    && bash /installers/weakref.sh \
    # Install Composer
    && mkdir $COMPOSER_HOME \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    # Tune up PHP-CLI
    && TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php5/cli/php.ini \
    && TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php5/fpm/php.ini \
    && sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php5/cli/php.ini \
    && sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php5/cli/php.ini \
    && sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php5/cli/php.ini \
    && sed -i 's|display_errors =.*|display_errors = On|' /etc/php5/cli/php.ini \
    && sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php5/cli/php.ini \
    && sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php5/cli/php.ini \
    && sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php5/cli/php.ini \
    && echo "apc.enable_cli = 1" >> /etc/php5/mods-available/apcu.ini

# Cleanup
RUN apt-get purge -y -f \
        build-essential \
        make \
        re2c \
    && apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /installers \
        /opt/docker/etc/php5/fpm/pool.d/www.conf

# Expose ports
EXPOSE 80 443 9000
