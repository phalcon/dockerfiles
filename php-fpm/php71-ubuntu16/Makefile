VENDOR_NAME = phalconphp
PHP_VERSION= 7.1
BUILD_ID ?= $(shell /bin/date "+%Y%m%d-%H%M%S")

ifneq ("$(wildcard ./VERSION)","")
VERSION ?= $(shell cat ./VERSION | head -n 1)
else
VERSION ?= 0.0.1
$(shell echo $(VERSION) > ./VERSION)
endif

IMAGE_NAME ?= php$(PHP_VERSION)-ubuntu16
IMAGE_TAG ?= $(VERSION)
IMAGE_ALIAS = latest

.PHONY: build
build:
	docker build \
		--build-arg VERSION=$(VERSION) \
		--build-arg BUILD_ID=$(BUILD_ID) \
		--pull \
		-t $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) \
		--rm .

.PHONY: release
release: build tag push

.PHONY: tag
tag:
	docker tag $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG) $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_ALIAS)

.PHONY: push
push:
	docker push $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker push $(VENDOR_NAME)/$(IMAGE_NAME):$(IMAGE_ALIAS)
