#
# Composer for PHP 7 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/composer:7

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set up the application directory
VOLUME ["/app"]
RUN apk update && apk add git && composer global require phalcon/devtools \
    && mv /root/.composer/vendor/bin/phalcon.php /root/.composer/vendor/bin/phalcon \
    && export PATH=/root/.composer/vendor/bin:$PATH
# Define working directory
ADD devtools.sh /bin/devtools
RUN chmod +x /bin/devtools
RUN devtools
WORKDIR /app
ENTRYPOINT ["devtools"]
# Set up the command arguments
CMD ["devtools"]
