#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

required_vars=(FPM_MAX_CHILDREN FPM_START_SERVERS FPM_MIN_SPARE_SERVERS FPM_MAX_SPARE_SERVERS FPM_PROCESS_IDLE_TIMEOUT FPM_MAX_REQUEST)
missing_vars=()

for i in "${required_vars[@]}"; do
    test -n "${!i:+y}" || missing_vars+=("$i")
done

if [ ${#missing_vars[@]} -ne 0 ]; then
    echo "Variables aren't set: " >&2
    printf ' %q\n' "${missing_vars[@]}" >&2
    exit 1
fi

/usr/local/bin/go-replace --regex \
	-s '^[;s]*pm.max_children[\s]*=.*'         -r "pm.max_children = ${FPM_MAX_CHILDREN}" \
	-s '^[;s]*pm.start_servers[\s]*=.*'        -r "pm.start_servers = ${FPM_START_SERVERS}" \
	-s '^[;s]*pm.min_spare_servers[\s]*=.*'    -r "pm.min_spare_servers = ${FPM_MIN_SPARE_SERVERS}" \
	-s '^[;s]*pm.max_spare_servers[\s]*=.*'    -r "pm.max_spare_servers = ${FPM_MAX_SPARE_SERVERS}" \
	-s '^[;s]*pm.process_idle_timeout[\s]*=.*' -r "pm.process_idle_timeout = ${FPM_PROCESS_IDLE_TIMEOUT}" \
	-s '^[;s]*pm.max_requests[\s]*=.*'         -r "pm.max_requests = ${FPM_MAX_REQUEST}" \
	/etc/php/7.1/fpm/pool.d/www.conf
