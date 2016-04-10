
#!/usr/bin/env bash

patch -p0 < /root/alpine.patch

set -eufo pipefail
BEANSTALKD_VERSION="1.10"
BEANSTALKD_CLI_VERSION="0.3.0"

src_url="https://github.com/kr/beanstalkd/archive/v${BEANSTALKD_VERSION}.tar.gz"
cli_url="https://github.com/schickling/beanstalkd-cli/releases/download/${BEANSTALKD_CLI_VERSION}/beanstalkd-cli-linux.tar.gz"


mkdir $HOME/bin
cd /tmp

curl -L "$src_url" | tar xz
pushd "beanstalkd-${BEANSTALKD_VERSION}"
    make CFLAGS="-g3 -O2 -Wall"
    mv beanstalkd "$HOME/bin"
popd

curl -L "$cli_url" | tar xz
mv beanstalkd-cli "$HOME/bin"

cd $HOME
rm -rf /tmp/* /root/alpine.patch
