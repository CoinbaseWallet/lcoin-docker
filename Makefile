VERSION?=v1.0.0-beta.15-petejkim-3

DOCKER_REPO?=petejkim/lcoin
DOCKER_FULLTAG=$(DOCKER_REPO):$(VERSION)

# LCOIN_CHECKOUT?=tags/$(VERSION)
LCOIN_CHECKOUT?=70332649267ce18f95100d4ebb1b88cd34893ce2

build:
	@echo "building: $(DOCKER_FULLTAG)"
	@docker build -t $(DOCKER_FULLTAG) \
		--build-arg LCOIN_VERSION=$(LCOIN_CHECKOUT) \
		.

# Current option for latest:
latest: build
	@echo "Tagging latest"
	@docker tag $(DOCKER_FULLTAG) $(DOCKER_REPO):latest

master: DOCKER_TAG=master
master: LCOIN_CHECKOUT=master
master: build

.PHONY: build latest
