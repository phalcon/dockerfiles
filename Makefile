ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

.PHONY: build
build: build-ubuntu build-alpine build-beanstalkd

.PHONY: release
release: release-ubuntu release-alpine release-beanstalkd

.PHONY: build-ubuntu
build-ubuntu: build-bootstraps-ubuntu build-builders-ubuntu build-base-ubuntu

.PHONY: release-ubuntu
release-ubuntu: release-bootstraps-ubuntu release-builders-ubuntu release-base-ubuntu

.PHONY: build-alpine
build-alpine: build-bootstraps-alpine build-builders-alpine build-base-alpine

.PHONY: release-alpine
release-alpine: release-bootstraps-alpine release-builders-alpine release-base-alpine

.PHONY: build-beanstalkd
build-beanstalkd:
	cd beanstalkd/1.10 && $(MAKE) build

.PHONY: release-beanstalkd
release-beanstalkd:
	cd beanstalkd/1.10 && $(MAKE) release

.PHONY: build-base
build-base: build-base-ubuntu build-base-alpine

.PHONY: release-base
release-base: release-base-ubuntu release-base-alpine

.PHONY: build-builders
build-builders: build-builders-ubuntu

.PHONY: release-builders
release-builders: release-builders-ubuntu

.PHONY: build-bootstraps
build-bootstraps: build-bootstraps-ubuntu build-bootstraps-alpine

.PHONY: release-bootstraps
release-bootstraps: release-bootstraps-ubuntu release-bootstraps-alpine

.PHONY: build-base-ubuntu
build-base-ubuntu:
	cd base/ubuntu-12.04 && $(MAKE) build
	cd base/ubuntu-14.04 && $(MAKE) build
	cd base/ubuntu-16.04 && $(MAKE) build
	cd base/ubuntu-18.04 && $(MAKE) build

.PHONY: release-base-ubuntu
release-base-ubuntu:
	cd base/ubuntu-12.04 && $(MAKE) release
	cd base/ubuntu-14.04 && $(MAKE) release
	cd base/ubuntu-16.04 && $(MAKE) release
	cd base/ubuntu-18.04 && $(MAKE) release

.PHONY: build-base-alpine
build-base-alpine:
	cd base/alpine-3.4 && $(MAKE) build

.PHONY: release-base-alpine
release-base-alpine:
	cd base/alpine-3.4 && $(MAKE) release

.PHONY: build-builders-ubuntu
build-builders-ubuntu:
	cd build/ubuntu-trusty     && $(MAKE) build
	cd build/ubuntu-trusty-7.0 && $(MAKE) build
	cd build/ubuntu-trusty-7.1 && $(MAKE) build
	cd build/ubuntu-trusty-7.2 && $(MAKE) build
	cd build/ubuntu-xenial     && $(MAKE) build
	cd build/ubuntu-xenial-7.1 && $(MAKE) build
	cd build/ubuntu-xenial-7.2 && $(MAKE) build
	cd build/ubuntu-bionic     && $(MAKE) build
	cd build/ubuntu-bionic-7.1 && $(MAKE) build
	cd build/ubuntu-bionic-7.2 && $(MAKE) build

.PHONY: release-builders-ubuntu
release-builders-ubuntu:
	cd build/ubuntu-trusty     && $(MAKE) release
	cd build/ubuntu-trusty-7.0 && $(MAKE) release
	cd build/ubuntu-trusty-7.1 && $(MAKE) release
	cd build/ubuntu-trusty-7.2 && $(MAKE) release
	cd build/ubuntu-xenial     && $(MAKE) release
	cd build/ubuntu-xenial-7.1 && $(MAKE) release
	cd build/ubuntu-xenial-7.2 && $(MAKE) release
	cd build/ubuntu-bionic     && $(MAKE) release
	cd build/ubuntu-bionic-7.1 && $(MAKE) release
	cd build/ubuntu-bionic-7.2 && $(MAKE) release

.PHONY: build-bootstraps-ubuntu
build-bootstraps-ubuntu:
	cd bootstrap/ubuntu-12.04 && $(MAKE) build
	cd bootstrap/ubuntu-14.04 && $(MAKE) build
	cd bootstrap/ubuntu-16.04 && $(MAKE) build
	cd bootstrap/ubuntu-18.04 && $(MAKE) build

.PHONY: release-bootstraps-ubuntu
release-bootstraps-ubuntu:
	cd bootstrap/ubuntu-12.04 && $(MAKE) release
	cd bootstrap/ubuntu-14.04 && $(MAKE) release
	cd bootstrap/ubuntu-16.04 && $(MAKE) release
	cd bootstrap/ubuntu-18.04 && $(MAKE) release

.PHONY: build-builders-alpine
build-builders-alpine:
	cd build/alpine-3.4 && $(MAKE) build

.PHONY: release-builders-alpine
release-builders-alpine:
	cd build/alpine-3.4 && $(MAKE) release

.PHONY: build-bootstraps-alpine
build-bootstraps-alpine:
	cd bootstrap/alpine-3.4 && $(MAKE) build

.PHONY: release-bootstraps-alpine
release-bootstraps-alpine:
	cd bootstrap/alpine-3.4 && $(MAKE) release
