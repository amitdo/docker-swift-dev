FROM debian:latest
MAINTAINER Bartosz Janda

ENV BUILD_NAME "debian_latest"
WORKDIR /swift
RUN apt-get update && apt-get install -y \
        autoconf \
        clang \
        cmake \
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

COPY build.sh swift-build-presets /swift_build/
CMD ["/swift_build/build.sh"]
