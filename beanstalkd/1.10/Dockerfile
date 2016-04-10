#
# Beanstalkd Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/alpine:3.3

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Set environment variables
ENV PATH /root/bin:$PATH

# Fix fatal error: 'fcntl.h' file not found
COPY alpine.patch /root/alpine.patch

# Install Beanstalk
ADD install.sh /install.sh
RUN bash /install.sh && rm /install.sh

# Expose ports
EXPOSE 11300

# Expose volumes
VOLUME ["/data"]

# Set up the command arguments
CMD ["beanstalkd", "-p", "11300", "-b", "/data"]
