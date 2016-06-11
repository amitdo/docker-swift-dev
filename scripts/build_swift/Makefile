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
	$(REPOS_CLEAN) clean clean-swift clean-isntall clean-all \
	$(REPOS_CHECKOUT_TAG) checkout-tag checkout-master checkout-master-next checkout-swift-3

all:

# Build
$(IMAGES):
	-docker run --rm -it -v ${PWD}:/swift -v swift_build_$@:/swift_build --privileged bartoszj/swift-dev:$@
build: $(IMAGES)

# Clean
$(REPOS_CLEAN):
	$(eval repo = $(@:%-clean=%))
	-git -C $(repo) clean -fdx
clean: $(REPOS_CLEAN)
clean-swift:
	rm swift_*.tar.gz || true
clean-isntall:
	rm -r install_* || true
clean-all: clean clean-swift clean-isntall

# Checkout tag
$(REPOS_CHECKOUT_TAG):
	$(eval repo = $(@:%-tag=%))
	-git -C $(repo) checkout -q $(tag)
checkout-tag: $(REPOS_CHECKOUT_TAG)
# Checkot branch
checkout-master:
	./swift/utils/update-checkout --branch master
checkout-master-next:
	./swift/utils/update-checkout --branch master-next
checkout-swift-3:
	./swift/utils/update-checkout --branch swift-3.0-branch
