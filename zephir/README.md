# Phalcon Zephir Dockerfile

## Base Docker Image

[phalconphp/php](https://hub.docker.com/r/phalconphp/php/)

## Installation

1. Install [Docker](https://www.docker.com/)
2. Download [build](https://hub.docker.com/r/phalconphp/zephir/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull phalconphp/zephir:<PHP_VERSION>`
  Where `<PHP_VERSION>` is: 5.4, 5.5, 5.6 ot 7

## Usage

```sh
$ docker run --rm -it phalconphp/zephir:<PHP_VERSION>
```

### Creating alias

Create file called `/usr/local/bin/zephir` as follows:

```sh
#!/usr/bin/env bash

docker_bin="$(which docker.io 2> /dev/null || which docker 2> /dev/null)"

# 5.4, 5.5, 5.6, 7
PHP_VERSION=7

${docker_bin} run -it --rm \
    --privileged=true \
    -e ZEND_DONT_UNLOAD_MODULES=1 \
    -v $(pwd):/zephir \
    phalconphp/zephir:${PHP_VERSION} "zephir $@"

ret=$?

if [ ${ret} -ne 0 ]; then
    errors="$(pwd)/compile-errors.log"
    if [ -e ${errors} ]; then
        cat ${errors}
    fi
fi
```

Make it executable:

```sh
$ sudo chmod a+x /usr/local/bin/zephir
```

Test:

```sh
$ zephir version
0.9.3a-dev
```
