IMAGES := \
	jessie \
	stretch \
	sid \
	trusty \
	wily \
	xenial
IMAGES_BUILD_COPY := $(IMAGES:%=%-build-copy)
REPOS := \
	clang \
	cmark \
	compiler-rt \
	llbuild \
	lldb \
	llvm \
	swift \
	swift-corelibs-foundation \
	swift-corelibs-libdispatch \
	swift-corelibs-xctest \
	swift-integration-tests \
	swiftpm
REPOS_CLEAN := $(REPOS:%=%-clean)
REPOS_CHECKOUT_TAG := $(REPOS:%=%-tag)

.PHONY: \
	$(IMAGES) build \
	$(IMAGES_BUILD_COPY) copy-src build-copy \
	$(REPOS_CLEAN) clean clean-output clean-volume clean-all \
	$(REPOS_CHECKOUT_TAG) checkout-tag checkout-master checkout-master-next checkout-swift-3

all:

# Build Swift for given image
$(IMAGES):
	-docker run --rm -it --name swift_$(@) -v ${PWD}:/src -v ${PWD}/output:/output -v swift_build_$@:/build --privileged bartoszj/swift-dev:$@
build: $(IMAGES)

# Copy sources
copy-src: clean-volume
	docker run --rm -it --name copy_swift_src -v ${PWD}:/orig -v swift_src:/src rsync -rltDq --delete --delete-excluded /orig/ /src

# Build from copied sources
$(IMAGES_BUILD_COPY):
	$(eval image = $(@:%-build-copy=%))
	-docker run --rm -it --name swift_$(@) -v swift_src:/src -v ${PWD}/output:/output -v swift_build_$@:/build --privileged bartoszj/swift-dev:$(image)
build-copy: $(IMAGES_BUILD_COPY)

# Clean Git repositories, Swift archives and installations folders
$(REPOS_CLEAN):
	$(eval repo = $(@:%-clean=%))
	-git -C $(repo) clean -fdx
clean: $(REPOS_CLEAN)
clean-output:
	rm -r output || true
clean-src-volume:
	-docker volume rm swift_src
clean-all: clean clean-output clean-src-volume

# Checkout repositories to given tag:
# make tag="<TAG_NAME>" checkout-tag
# 
# or to predefined branches: master, master-next and swift-3
$(REPOS_CHECKOUT_TAG):
	$(eval repo = $(@:%-tag=%))
	-git -C $(repo) checkout -q $(tag)
	-git -C $(repo) submodule update --recursive
checkout-tag: $(REPOS_CHECKOUT_TAG)
# Checkout branch
checkout-master:
	./swift/utils/update-checkout --branch master
checkout-master-next:
	./swift/utils/update-checkout --branch master-next
checkout-swift-3:
	./swift/utils/update-checkout --branch swift-3.0-branch
