NAME = phalconphp/build
VERSION = centos7-ius73
SHELL = /bin/bash

build: pre-build docker-build post-build

.PHONY: pre-build
pre-build:

.PHONY: post-build
post-build:

.PHONY: docker-build
docker-build:
	docker build --pull -t $(NAME):$(VERSION) --no-cache --force-rm --compress .

.PHONY: release
release: build push

.PHONY: push
push: do-push post-push

.PHONY: do-push
do-push:
	docker push $(NAME):$(VERSION)

.PHONY: post-push
post-push:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
