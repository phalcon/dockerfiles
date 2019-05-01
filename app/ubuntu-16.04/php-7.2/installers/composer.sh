#!/usr/bin/env bash

# trace ERR through pipes
set -o pipefail

# trace ERR through 'time command' and other functions
set -o errtrace

# set -u : exit the script if you try to use an uninitialised variable
set -o nounset

# set -e : exit the script if any statement returns a non-true return value
set -o errexit

mkdir -p /usr/local/bin

export COMPOSER_HOME=$COMPOSER_HOME
export PATH=$PATH
export COMPOSER_ALLOW_SUPERUSER=$COMPOSER_ALLOW_SUPERUSER

mkdir $COMPOSER_HOME

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
chmod +x /usr/local/bin/composer

mkdir -p /artifacts/usr/local/bin
cp /usr/local/bin/composer /artifacts/usr/local/bin

composer --version --no-ansi
