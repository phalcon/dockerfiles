NAME = phalconphp/nginx
VERSION = 1.12
ALIAS = 1.12.2
SHELL = /bin/bash
BUILD_ID ?= $(shell /bin/date "+%Y%m%d-%H%M%S")

.PHONY: build
build: pre-build docker-build post-build

.PHONY: pre-build
pre-build:

.PHONY: post-build
post-build:

.PHONY: docker-build
docker-build:
	docker build -t $(NAME):$(VERSION) --build-arg VERSION=$(VERSION) --build-arg BUILD_ID=$(BUILD_ID) --no-cache --force-rm --compress .

.PHONY: release
release: build tag push

.PHONY: tag
tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS)

.PHONY: push
push: do-push post-push

.PHONY: do-push
do-push:
	docker push $(NAME):$(VERSION)
	docker push $(NAME):$(ALIAS)

.PHONY: post-push
post-push:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
