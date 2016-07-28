FROM ubuntu:trusty
MAINTAINER Bartosz Janda

ENV BUILD_NAME trusty
# Folder where build files will be stored
ENV SWIFT_BUILD_ROOT /build

# Required. Volume mounted from host to access source codes
VOLUME ["/src"]
# Optional. Volume to store installation packages and build logs
VOLUME ["/output"]
WORKDIR /src
# Ubuntu Trusty (14.04) requires clang-3.6 and cmake 3.x
RUN  apt-get update && apt-get install -y \ 
        software-properties-common \ 
    && add-apt-repository -y ppa:george-edison55/cmake-3.x \ 
    && apt-get update && apt-get install -y \ 
        autoconf \
        clang-3.6 \
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
    && rm -rf /var/lib/apt/lists/* \ 
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 \ 
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100

COPY build.sh swift-build-presets.ini /build_scripts/
CMD ["/build_scripts/build.sh"]
