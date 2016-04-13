#
# Zephir for PHP 5.6 Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/php:5.6

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV ZEPHIRDIR /usr/share/zephir

# Install Zephir
RUN mkdir -p /usr/share/zephir && \
    git clone --depth=1 -v https://github.com/phalcon/zephir /tmp/zephir && \
    cd /tmp/zephir && \
    echo "#!/usr/bin/env bash\nexec \"\$@\"" | tee /usr/bin/sudo &&  \
    chmod +x /usr/bin/sudo && \
    ./install -c && \
    cd / && rm -rf /tmp/zephir

# Set up the application directory
VOLUME ["/zephir"]

# Define working directory
WORKDIR /zephir

# Set up the command arguments
ENTRYPOINT ["zephir"]
CMD ["help"]
