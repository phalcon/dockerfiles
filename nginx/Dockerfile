#
# Nginx Stable Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM phalconphp/ubuntu:14.04.4

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Adding repositories
RUN add-apt-repository -y ppa:nginx/stable && \
    apt-get update -y && apt-get upgrade -y

# Install Nginx
RUN apt-get install -y --force-yes --no-install-recommends nginx

# Cleanup package manager
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add files
RUN mkdir /etc/nginx/global && \
    mkdir /etc/nginx/certs

# Apply Nginx configuration
ADD conf/restrict.conf /etc/nginx/global/restrict.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf

RUN usermod -u 1000 www-data

RUN chown -R www-data:www-data /var/lib/nginx && \
    rm -rf /etc/nginx/sites-enabled/*

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]

# Expose ports
EXPOSE 80 443

# Define default command
CMD ["nginx", "-g", "daemon off;"]
