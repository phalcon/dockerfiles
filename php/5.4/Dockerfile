#
# PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php-base

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN phpenv global 5.4.45

RUN TIMEZONE=`cat /etc/timezone`; sed -i "s|;date.timezone =.*|date.timezone = ${TIMEZONE}|" /usr/local/phpenv/versions/$(phpenv global)/etc/php.ini && \
    sed -i "s|memory_limit =.*|memory_limit = -1|" /usr/local/phpenv/versions/$(phpenv global)/etc/php.ini

# Set up the command arguments
ENTRYPOINT ["php"]
CMD ["-v"]
