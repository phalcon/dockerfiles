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
    VAULT_CONFIG_DIR="/etc/vault" \
    VAULT_LOG_DIR="/var/log/vault" \
    VAULT_LOCAL_DB="/var/db/vault"

LABEL vendor=Phalcon\ Framework \
      com.phalconphp.image-specs="{\"Description\":\"Vault Image\",\"License\":\"BSD\",\"Version\":\"1.0.0\",\"Layouts\":9}"

# Set up Vault
ADD entrypoint.sh /docker-entrypoint.sh

RUN apk --no-cache add wget && \
    wget --quiet --output-document=/tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip /tmp/vault.zip -d /usr/local/bin && \
    # /var/db/vault is made available to use as a location with the file torage
    # backend, if desired
    mkdir -p /var/db/vault && \
    # /var/log/vault is made available to use as a location to store audit logs,
    # if desired
    mkdir -p ${VAULT_LOG_DIR} && \
    # the server will be started with /etc/vault as the configuration directory so
    # you can add additional config files in that location.
    mkdir -p ${VAULT_CONFIG_DIR} && \
    chmod +x /docker-entrypoint.sh && \
    # Cleanup
    apk del wget && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Set up the exposed volumes
#
# Expose the /var/db/vault directory as a volume since there's potentially
# long-running state in there
VOLUME ["/var/db/vault", "/var/log/vault"]

# Listener API tcp port
#
# 8200/tcp is the primary interface that applications use to interact with
# Vault.
EXPOSE 8200

# The entry point script uses dumb-init as the top-level process to reap any
# zombie processes created by Vault sub-processes.
#
# For production derivatives of this container, you shoud add the IPC_LOCK
# capability so that Vault can mlock memory.
ENTRYPOINT ["/docker-entrypoint.sh"]

# By default you'll get a single-node development server that stores everything
# in RAM and bootstraps itself. Don't use this configuration for production.
CMD ["server", "-dev"]
