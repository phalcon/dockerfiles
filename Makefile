ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

.PHONY: build
build: build-ubuntu build-centos build-alpine

.PHONY: release
release: release-ubuntu release-centos release-alpine

.PHONY: build-ubuntu
build-ubuntu: build-bootstraps-ubuntu build-builders-ubuntu

.PHONY: release-ubuntu
release-ubuntu: release-bootstraps-ubuntu release-builders-ubuntu

.PHONY: build-centos
build-centos: build-bootstraps-centos build-builders-centos

.PHONY: release-centos
release-centos: release-bootstraps-centos release-builders-centos

.PHONY: build-alpine
build-alpine: build-bootstraps-alpine build-builders-alpine

.PHONY: release-alpine
release-alpine: release-bootstraps-alpine release-builders-alpine

.PHONY: build-builders
build-builders: build-builders-ubuntu build-builders-centos build-builders-alpine

.PHONY: release-builders
release-builders: release-builders-ubuntu release-builders-centos release-builders-alpine

.PHONY: build-bootstraps
build-bootstraps: build-bootstraps-ubuntu build-bootstraps-centos build-bootstraps-alpine

.PHONY: release-bootstraps
release-bootstraps: release-bootstraps-ubuntu release-bootstraps-centos release-bootstraps-alpine

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

.PHONY: build-builders-centos
build-builders-centos:
	cd build/centos7       && $(MAKE) build
	cd build/centos7-ius55 && $(MAKE) build
	cd build/centos7-ius56 && $(MAKE) build
	cd build/centos7-ius70 && $(MAKE) build
	cd build/centos7-ius71 && $(MAKE) build
	cd build/centos7-ius72 && $(MAKE) build

.PHONY: release-builders-centos
release-builders-centos:
	cd build/centos7       && $(MAKE) release
	cd build/centos7-ius55 && $(MAKE) release
	cd build/centos7-ius56 && $(MAKE) release
	cd build/centos7-ius70 && $(MAKE) release
	cd build/centos7-ius71 && $(MAKE) release
	cd build/centos7-ius72 && $(MAKE) release

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

.PHONY: build-bootstraps-centos
build-bootstraps-centos:
	cd bootstrap/centos-7 && $(MAKE) build

.PHONY: release-bootstraps-centos
release-bootstraps-centos:
	cd bootstrap/centos-7 && $(MAKE) release

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
