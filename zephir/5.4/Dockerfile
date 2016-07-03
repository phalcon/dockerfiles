#
# Zephir for PHP 5.4 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV ZEPHIRDIR=/usr/share/zephir \
    PATH=$PATH:/usr/share/zephir/bin

COPY docker-entrypoint.sh /usr/local/bin/

# Install Zephir
RUN mkdir -p /usr/share/zephir && \
    git clone --depth=1 -v https://github.com/phalcon/zephir /tmp/zephir && \
    cd /tmp/zephir && \
    echo "#!/usr/bin/env bash\nexec \"\$@\"" | tee /usr/bin/sudo &&  \
    chmod +x /usr/bin/sudo && \
    (cd parser && phpize --clean) && \
    ./install -c && \
    cd / && rm -rf /tmp/zephir && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

# Set up the Zephir directory
VOLUME ["/zephir"]

# Define working directory
WORKDIR /zephir

# Set up the command arguments
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["zephir"]
