FROM ubuntu:xenial
MAINTAINER Bartosz Janda

ENV BUILD_NAME xenial
# Folder where build files will be stored
ENV SWIFT_BUILD_ROOT /build

# Required. Volume mounted from host to access source codes
VOLUME ["/src"]
# Optional. Volume to store installation packages and build logs
VOLUME ["/output"]
WORKDIR /src
# Ubuntu Trusty (14.04) requires clang-3.6
RUN apt-get update && apt-get install -y \
        autoconf \
        clang \
        cmake \
        g++ \
        git \
        icu-devtools \
        libblocksruntime-dev \
        libbsd-dev \
        libedit-dev \
        libicu-dev \
        libkqueue-dev \
        libncurses5-dev \
        libpython-dev \
        libsqlite3-dev \
        libtool \
        libxml2-dev \
        ninja-build \
        pkg-config \
        python \
        python3 \
        swig \
        uuid-dev \
    && rm -rf /var/lib/apt/lists/*

COPY build.sh swift-build-presets.ini /build_scripts/
CMD ["/build_scripts/build.sh"]
