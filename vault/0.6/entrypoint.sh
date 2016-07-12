#!/usr/bin/env sh
set -e

# VAULT_CONFIG_DIR isn't exposed as a volume but you can compose additional
# config files in there if you use this image as a base, or use
# VAULT_LOCAL_CONFIG below.
#
# You can also set the VAULT_LOCAL_CONFIG environment variable to pass some
# Vault configuration JSON without having to bind any volumes.

echo "${VAULT_LOCAL_CONFIG}" > "${VAULT_CONFIG_DIR}/local.json"

# If the user is trying to run Vault directly with some arguments, then
# pass them to Vault.
if [ "${1:0:1}" = '-' ]; then
    set -- vault "$@"
fi

# Look for Vault subcommands.
if [ "$1" = 'server' ]; then
    shift
    set -- vault server \
        -config="${VAULT_CONFIG_DIR}" \
        -dev-root-token-id="${VAULT_DEV_ROOT_TOKEN_ID}" \
        -dev-listen-address="${VAULT_DEV_LISTEN_ADDRESS}" \
        "$@"
elif [ "$1" = 'version' ]; then
    # This needs a special case because there's no help output.
    set -- version "$@"
elif vault --help "$1" 2>&1 | grep -q "vault $1"; then
    # We can't use the return code to check for the existence of a subcommand, so
    # we have to use grep to look for a pattern in the help output.
    set -- vault "$@"
fi

exec $@

ret=$?

if [ ${ret} -eq 0 ]; then
    exit 0;
fi

echo -e "------------------------------------------------------------"
echo -e "The command '${@}' terminated with non-zero status code."
echo -e "------------------------------------------------------------"
