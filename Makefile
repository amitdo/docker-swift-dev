IMAGE_NAME := bartoszj/swift-dev
IMAGES := \
	jessie \
	stretch \
	sid \
	trusty \
	wily \
	xenial

.PHONY: \
	update \
	build $(IMAGES)

all: update

# Update Dockerfiles using templates
update:
	./update.sh

# Build one image
$(IMAGES):
	docker build -t $(IMAGE_NAME):$(@) $(@)

# Build all images
build: $(IMAGES)
