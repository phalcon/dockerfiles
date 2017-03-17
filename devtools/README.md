# Phalcon Devtools

Command line devtools

This image is updated via pull requests to the `phalconphp/dockerfiles` [GitHub repo](https://github.com/phalcon/dockerfiles).

## How to use this image

You can run the default `phalcon` command simply:

```
$ docker run -it --rm phalconphp/devtools:7 help
```

And you can create alias in order to implement convenient runner. Create file called `/usr/local/bin/devtools` as follows:

```sh
#!/usr/bin/env bash

mkdir -p ${HOME}/.ssh
mkdir -p ${HOME}/.composer

docker run -it --rm \
    -v $(pwd):/app \
    phalconphp/devtools:7 "${*:1}"
```

Make it executable:

```
$ sudo chmod a+x /usr/local/bin/devtools
```

Test:

```
$ devtools
Phalcon DevTools (3.0.5)

Available commands:
  info             (alias of: i)
  commands         (alias of: list, enumerate)
  controller       (alias of: create-controller)
  module           (alias of: create-module)
  model            (alias of: create-model)
  all-models       (alias of: create-all-models)
  project          (alias of: create-project)
  scaffold         (alias of: create-scaffold)
  migration        (alias of: create-migration)
  webtools         (alias of: create-webtools)
```

WIP readme PRs welcome