#
# Zephir for PHP 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.6

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV ZEPHIRDIR=/usr/share/zephir \
    PATH=$PATH:/usr/share/zephir/bin

COPY docker-entrypoint.sh /docker-entrypoint.sh

# Install Zephir
RUN mkdir -p /usr/share/zephir && \
    git clone --depth=1 -v https://github.com/phalcon/zephir /tmp/zephir && \
    cd /tmp/zephir && \
    echo "#!/usr/bin/env bash\nexec \"\$@\"" | tee /usr/bin/sudo &&  \
    chmod +x /usr/bin/sudo && \
    ./install -c && \
    chmod +x /docker-entrypoint.sh && \
    rm -rf /tmp/*

# Set up the Zephir directory
VOLUME ["/zephir"]

# Define working directory
WORKDIR /zephir

# Set up the command arguments
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zephir"]
