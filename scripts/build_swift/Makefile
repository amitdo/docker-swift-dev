IMAGES := \
	jessie \
	stretch \
	sid \
	trusty \
	wily \
	xenial
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
	$(REPOS_CLEAN) clean clean-output clean-all \
	$(REPOS_CHECKOUT_TAG) checkout-tag checkout-master checkout-master-next checkout-swift-3

all:

# Build Swift for given image
$(IMAGES):
	-docker run --rm -it --name swift_$(@) -v ${PWD}:/src -v ${PWD}/output:/output -v swift_build_$@:/build --privileged bartoszj/swift-dev:$@
build: $(IMAGES)

# Clean Git repositories, Swift archives and installations folders
$(REPOS_CLEAN):
	$(eval repo = $(@:%-clean=%))
	-git -C $(repo) clean -fdx
clean: $(REPOS_CLEAN)
clean-output:
	rm -r output || true
clean-all: clean clean-output

# Checkout repositories to given tag:
# make tag="<TAG_NAME>" checkout-tag
# 
# or to predefined branches: master, master-next and swift-3
$(REPOS_CHECKOUT_TAG):
	$(eval repo = $(@:%-tag=%))
	-git -C $(repo) checkout -q $(tag)
checkout-tag: $(REPOS_CHECKOUT_TAG)
# Checkout branch
checkout-master:
	./swift/utils/update-checkout --branch master
checkout-master-next:
	./swift/utils/update-checkout --branch master-next
checkout-swift-3:
	./swift/utils/update-checkout --branch swift-3.0-branch
