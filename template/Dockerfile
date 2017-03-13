FROM debian:latest
MAINTAINER Bartosz Janda

ENV BUILD_NAME debian_latest
# Folder where build files will be stored
ENV SWIFT_BUILD_ROOT /build

# Required. Volume mounted from host to access source codes
VOLUME ["/src"]
# Optional. Volume to store installation packages and build logs
VOLUME ["/output"]
WORKDIR /src
# Ubuntu Trusty the Clang 3.8 and CMake >= 3.4.3 have to be installed
# Debian Jessie CMake >= 3.4.3 have to be installed
# Debian Stretch and Sid the Clang 3.8, Swig 3.0.7, libedit 3.1-20150325-1 have to be installed
RUN apt-get update && apt-get install -y \
        autoconf \
        clang \
        cmake \
        g++ \
        git \
        icu-devtools \
        libblocksruntime-dev \
        libbsd-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libicu-dev \
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
        systemtap-sdt-dev \
        uuid-dev \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/*

COPY build.sh swift-build-presets.ini /build_scripts/
CMD ["/build_scripts/build.sh"]
