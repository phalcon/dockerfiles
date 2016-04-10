#
# PHP 5.5 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php-base

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

RUN phpenv global 5.5.34

# Set up the command arguments
ENTRYPOINT ["php"]
CMD ["-v"]
