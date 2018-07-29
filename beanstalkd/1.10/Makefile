NAME = phalconphp/beanstalkd
VERSION = 1.10
ALIAS = 1
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
release: build tag push

.PHONY: tag
tag:
	docker tag $(NAME):$(VERSION) $(NAME):$(ALIAS)
	docker tag $(NAME):$(VERSION) $(NAME):latest

.PHONY: push
push: do-push post-push

.PHONY: do-push
do-push:
	docker push $(NAME):$(VERSION)
	docker push $(NAME):$(ALIAS)
	docker push $(NAME):latest

.PHONY: post-push
post-push:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
