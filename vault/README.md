# Vault

Vault is a tool for securely accessing secrets.

## Supported tags and respective `Dockerfile` links

* `0.6`, `0.6.0`, `latest` [(0.6/Dockerfile)](https://github.com/phalcon/dockerfiles/tree/master/vault/0.6)

This image is updated via pull requests to the `phalconphp/dockerfiles` [GitHub repo](https://github.com/phalcon/dockerfiles).

## What is Vault?

Vault secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in
modern computing. Vault handles leasing, key revocation, key rolling, and auditing. Vault presents a unified API to
access multiple backends: HSMs, AWS IAM, SQL databases, raw key/value, and more.

> [www.vaultproject.io](https://www.vaultproject.io/)

## How to use this image

You can run the default `vault` command simply:

```
$ docker run -it --rm --cap-add IPC_LOCK phalconphp/vault vault
```

You can also pass in additional flags to `vault`:

```
$ docker run -d \
  --cap-add IPC_LOCK \
  --name vs \
  -v $(pwd)/custom.conf:/etc/custom.conf:ro \
  -p 127.0.0.1:8200:9000 \
  phalconphp/vault server -config /etc/custom.conf
```

Then you can get access via CLI tool:

```
$ docker exec -it vs vault help
```

And you can create alias in order to implement convenient runner. Create file called `/usr/local/bin/vault` as follows:

```sh
#!/usr/bin/env bash

docker_bin="$(which docker 2> /dev/null)"

${docker_bin} run -it \
  --rm \
  --cap-add IPC_LOCK \
  --name vs \
  -p 127.0.0.1:8200:9000 \
  phalconphp/vault "$@"
```

Make it executable:

```
$ sudo chmod a+x /usr/local/bin/vault
```

Test:

```
$ vault version
Vault v0.6.0
```

## License

View [license](https://github.com/hashicorp/vault/blob/master/LICENSE) information for the software contained in this image.


## Supported Docker versions

This image is officially supported on Docker version 1.12.0.

Support for older versions (down to 1.10) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.
