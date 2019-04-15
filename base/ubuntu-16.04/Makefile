NAME = phalconphp/base
VERSION = ubuntu-16.04
SHELL = /bin/bash

.PHONY: build
build: pre-build docker-build post-build

.PHONY: pre-build
pre-build:

.PHONY: post-build
post-build:

.PHONY: docker-build
docker-build:
	docker build -t $(NAME):$(VERSION) --no-cache --force-rm --compress .

.PHONY: release
release: build push

.PHONY: push
push: do-push post-push

.PHONY: do-push
do-push:
	docker push $(NAME):$(VERSION)

.PHONY: post-push
post-push:
