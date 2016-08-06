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
	swift-xcode-playground-support \
	swiftpm
REPOS_CLONE := $(REPOS:%=%-clone)
REPOS_CLEAN := $(REPOS:%=%-clean)
REPOS_CLEAN_SRC := $(REPOS:%=%-clean-src)
REPOS_CHECKOUT_TAG := $(REPOS:%=%-tag)
REPOS_CHECKOUT_MASTER := $(REPOS:%=%-master)

.PHONY: \
	$(IMAGES) build \
	$(IMAGES_BUILD_COPY) copy-src build-copy \
	$(REPOS_CLEAN) $(REPOS_CLEAN_SRC) clean clean-output clean-src-volume clean-src clean-all \
	$(REPOS_CLONE) clone \
	$(REPOS_CHECKOUT_TAG) checkout-tag \
	$(REPOS_CHECKOUT_MASTER) checkout-master

# Empty action
all:

# 
# Build source
# 
# Build Swift for given image
$(IMAGES):
	-docker run --rm -it --name swift_$(@) -v ${PWD}:/src -v ${PWD}/output:/output -v swift_build_$@:/build --privileged bartoszj/swift-dev:$@
build: $(IMAGES)

# 
# Copy sources
# 
copy-src:
	docker run --rm -it --name copy_swift_src -v ${PWD}:/orig -v swift_src:/src bartoszj/rsync -rltDq --exclude="output" --delete --delete-excluded /orig/ /src

# 
# Build source from copy
# 
$(IMAGES_BUILD_COPY):
	$(eval image = $(@:%-build-copy=%))
	-docker run --rm -it --name swift_$(@) -v swift_src:/src -v ${PWD}/output:/output -v swift_build_$@:/build --privileged bartoszj/swift-dev:$(image)
build-copy: $(IMAGES_BUILD_COPY)

# 
# Clean Git repositories, Swift archives, installations folders and source copy
# 
$(REPOS_CLEAN):
	$(eval repo = $(@:%-clean=%))
	-git -C $(repo) clean -fdx
clean: $(REPOS_CLEAN)
clean-output:
	rm -r output || true
clean-src-volume:
	-docker volume rm swift_src
$(REPOS_CLEAN_SRC):
	$(eval repo = $(@:%-clean-src=%))
	rm -rf $(repo)
clean-src: $(REPOS_CLEAN_SRC)
clean-all: clean clean-output clean-src-volume

# 
# Clone
# 
define get_repo_name
$(patsubst "%","", \
	$(if $(filter $(1),clang),swift-$(1)) \
	$(if $(filter $(1),cmark),swift-$(1)) \
	$(if $(filter $(1),compiler-rt),swift-$(1)) \
	$(if $(filter $(1),llbuild),swift-$(1)) \
	$(if $(filter $(1),lldb),swift-$(1)) \
	$(if $(filter $(1),llvm),swift-$(1)) \
	$(if $(filter $(1),swift),$(1)) \
	$(if $(filter $(1),swift-corelibs-foundation),$(1)) \
	$(if $(filter $(1),swift-corelibs-libdispatch),$(1)) \
	$(if $(filter $(1),swift-corelibs-xctest),$(1)) \
	$(if $(filter $(1),swift-integration-tests),$(1)) \
	$(if $(filter $(1),swift-xcode-playground-support),$(1)) \
	$(if $(filter $(1),swiftpm),swift-package-manager) )
endef
define get_repo_master
$(patsubst "%","", \
	$(if $(filter $(1),clang),stable) \
	$(if $(filter $(1),cmark),master) \
	$(if $(filter $(1),compiler-rt),stable) \
	$(if $(filter $(1),llbuild),master) \
	$(if $(filter $(1),lldb),master) \
	$(if $(filter $(1),llvm),stable) \
	$(if $(filter $(1),swift),master) \
	$(if $(filter $(1),swift-corelibs-foundation),master) \
	$(if $(filter $(1),swift-corelibs-libdispatch),master) \
	$(if $(filter $(1),swift-corelibs-xctest),master) \
	$(if $(filter $(1),swift-integration-tests),master) \
	$(if $(filter $(1),swift-xcode-playground-support),master) \
	$(if $(filter $(1),swiftpm),master) )
endef

$(REPOS_CLONE):
	$(eval repo := $(@:%-clone=%))
	$(eval repo_name := $(call get_repo_name,$(repo)))
	-git clone https://github.com/apple/$(repo_name).git $(repo)
	-git -C $(repo) submodule update --init --recursive
clone: $(REPOS_CLONE)

# Checkout repositories to given tag:
# make tag="<TAG_NAME>" checkout-tag
# 
# or to predefined branches: master, master-next and swift-3
$(REPOS_CHECKOUT_TAG):
	$(eval repo := $(@:%-tag=%))
	-git -C $(repo) checkout -q $(tag)
	-git -C $(repo) submodule update --init --recursive
checkout-tag: $(REPOS_CHECKOUT_TAG)
# Checkout branch
$(REPOS_CHECKOUT_MASTER):
	$(eval repo := $(@:%-master=%))
	$(eval master := $(call get_repo_master,$(repo)))
	-git -C $(repo) checkout -q $(master)
	-git -C $(repo) submodule update --init --recursive
checkout-master: $(REPOS_CHECKOUT_MASTER)
