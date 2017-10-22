#
# Dockerfile for phalconphp/php-apache:ubuntu-16.04
#
# https://github.com/phalcon/dockerfiles
#

FROM webdevops/php-apache-dev:ubuntu-16.04

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

COPY artifacts .

ENV PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_HOME=/root/composer \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HOME=/root/composer \
    APPLICATION_PATH="/project" \
    DEBIAN_FRONTEND=noninteractive

RUN ls -al artifacts

RUN mkdir -p $APPLICATION_PATH/public \
    && chown -R $APPLICATION_USER:$APPLICATION_GROUP $APPLICATION_PATH \
    && curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    && apt-add-repository ppa:ondrej/apache2 \
    && LANG=C.UTF-8 apt-add-repository -y ppa:ondrej/php \
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && apt-get update -y

RUN apt-get -o Dpkg::Options::="--force-confnew" install -y -f --no-install-recommends \
        php7.0-apcu \
        php-apcu-bc \
        php7.0-dev \
        php7.0-dba \
        php7.0-gmp \
        php-igbinary \
        php7.0-imagick \
        php7.0-imap \
        php-sodium \
        php-memcache \
        php7.0-mongodb \
        php7.0-msgpack \
        php-pear \
        php7.0-odbc \
        php7.0-pgsql \
        php7.0-pspell \
        php7.0-recode \
        php-ssh2 \
        php7.0-tidy \
        php-yaml \
        lsb-release \
        libssh2-1-dev \
        libyaml-dev \
        libssl-dev

RUN wget https://phar.io/releases/phive.phar \
    && wget https://phar.io/releases/phive.phar.asc \
    && gpg --keyserver hkps.pool.sks-keyservers.net --recv-keys 0x9B2D5D79 \
    && gpg --verify phive.phar.asc phive.phar \
    && chmod +x phive.phar \
    && mv phive.phar /usr/bin/phive \
    && pecl channel-update pecl.php.net \
    && curl -sOL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x phpcs.phar \
    && mv phpcs.phar /usr/local/bin/phpcs \
    && curl -sOL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar \
    && chmod +x phpcbf.phar \
    && mv phpcbf.phar /usr/local/bin/phpcbf \
    && curl -sOL http://static.phpmd.org/php/latest/phpmd.phar \
    && chmod +x phpmd.phar \
    && mv phpmd.phar /usr/local/bin/phpmd \
    && curl -sOL http://www.phing.info/get/phing-latest.phar \
    && chmod +x phing-latest.phar \
    && mv phing-latest.phar /usr/local/bin/phing \
    && mkdir $COMPOSER_HOME \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer

RUN cp -R /artifacts/etc/php/7.0/mods-available /etc/php/7.0/mods-available \
    && cp -R /artifacts/usr/lib/php/`php-config --phpapi` /usr/lib/php/`php-config --phpapi` \
    && FILES=/artifacts/etc/php/7.0/mods-available/* && for f in $FILES; \
        do \
            phpenmod -v 7.0 -s ALL `basename $f | cut -d '.' -f 1`; \
        done \
    && php -m

RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/7.0/cli/php.ini \
    && TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /etc/php/7.0/fpm/php.ini \
    && sed -i "s|memory_limit =.*|memory_limit = -1|" /etc/php/7.0/cli/php.ini \
    && sed -i 's|short_open_tag =.*|short_open_tag = On|' /etc/php/7.0/cli/php.ini \
    && sed -i 's|error_reporting =.*|error_reporting = -1|' /etc/php/7.0/cli/php.ini \
    && sed -i 's|display_errors =.*|display_errors = On|' /etc/php/7.0/cli/php.ini \
    && sed -i 's|display_startup_errors =.*|display_startup_errors = On|' /etc/php/7.0/cli/php.ini \
    && sed -i -re 's|^(;?)(session.save_path) =.*|\2 = "/tmp"|g' /etc/php/7.0/cli/php.ini \
    && sed -i -re 's|^(;?)(phar.readonly) =.*|\2 = off|g' /etc/php/7.0/cli/php.ini \
    && echo "apc.enable_cli = 1" >> /etc/php/7.0/mods-available/apcu.ini

RUN apt-get autoremove -y \
    && apt-get autoclean -y \
    && apt-get clean -y \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /artifacts \
        /opt/docker/etc/php/fpm/pool.d/www.conf

EXPOSE 80 443 9000
