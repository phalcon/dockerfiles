#
# Vault Dockerfile
#
# https://github.com/phalcon/dockerfiles
#

# Pull base image
FROM webdevops/base:alpine-3

MAINTAINER Serghei Iakovlev <serghei@phalconphp.com>

# Defines the Vault related environment variables
ENV VAULT_VERSION="0.6.0" \
    VAULT_HOME=/usr/local/bin

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Vault Image\",\"License\":\"BSD\",\"Version\":\"0.6.0\",\"Layouts\":10}"

ADD vault.conf /etc/vault.conf
ADD entrypoint.sh /docker-entrypoint.sh

RUN apk --no-cache add \
      bash \
      ca-certificates \
      libcap \
      wget && \
    wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d ${VAULT_HOME} && \
    mkdir -p /var/vault/storage && \
    chmod +x /docker-entrypoint.sh && \
    # Cleanup
    apk del wget && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Set up the Vault Storage directory
VOLUME ["/var/vault/storage"]

# Listener API tcp port
EXPOSE 8200 9000

# Set up the command arguments
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["vault"]
