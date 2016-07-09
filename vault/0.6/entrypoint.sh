#!/usr/bin/env bash

PURPLE="\e[0;35m"
GREEN="\033[0;32m"
YELLOW="\e[1;33m"
NC="\033[0m"

set -e

echo -e "\nWelcome to the containerized Vault."
echo -e "${GREEN}Vault${NC} version ${YELLOW}${VAULT_VERSION}${NC}"

ulimit -c unlimited

setcap cap_ipc_lock=+ep ${VAULT_HOME}/vault

# Add vault as command if needed
if [ "${1:0:5}" != 'vault' ]; then
    set -- vault "$@"
fi

# Add config as option if needed
if [ "${2:0:6}" == 'server' ]; then
    set -- vault "server -config /etc/vault.conf $@"
fi

exec $@

ret=$?

if [ ${ret} -eq 0 ]; then
    exit 0;
fi

echo -e "${PURPLE}The command '${@}' terminated with non-zero status code.${NC}"
