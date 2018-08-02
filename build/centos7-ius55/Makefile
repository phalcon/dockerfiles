NAME = phalconphp/build
TAG = centos7-ius55
SHELL = /bin/bash

.PHONY: pre-build docker-build post-build clean build release push do-push post-push

build: pre-build docker-build post-build

pre-build: all

post-build: clean

docker-build:
	$(info The PHP 5.5 no longer supported bu IUS repo maintainer)

release: build push

push: do-push post-push

do-push:
	$(info The PHP 5.5 no longer supported bu IUS repo maintainer)

post-push:

clean:

# vim:ft=make:noet:ci:pi:sts=0:sw=4:ts=4:tw=78:fenc=utf-8:et
