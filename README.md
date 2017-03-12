# Supported tags and respective `Dockerfile` links

[![Swift 2.2.1](https://img.shields.io/badge/Swift-2.2.1-orange.svg?style=flat)](https://swift.org/)
[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat)](https://swift.org/)
[![Travis](https://img.shields.io/travis/bartoszj/docker-swift-dev.svg)](https://travis-ci.org/bartoszj/docker-swift-dev)
[![Platforms Docker](https://img.shields.io/badge/Platforms-Docker-blue.svg?style=flat)](https://hub.docker.com/r/bartoszj/swift-dev/)
[![license](https://img.shields.io/github/license/bartoszj/docker-swift-dev.svg)](https://github.com/bartoszj/docker-swift-dev/blob/master/LICENSE)

- [`jessie`, `latest` (*jessie/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/jessie/Dockerfile)
- [`stretch` (*stretch/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/stretch/Dockerfile)
- [`sid` (*sid/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/sid/Dockerfile)
- [`trusty` (*trusty/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/trusty/Dockerfile)
- [`xenial` (*xenial/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/xenial/Dockerfile)
- [`yakkety` (*yakkety/Dockerfile*)](https://github.com/bartoszj/docker-swift-dev/blob/master/yakkety/Dockerfile)

Docker images for building Swift.  
https://hub.docker.com/r/bartoszj/swift-dev/

# What is Swift?

![Swift](https://raw.githubusercontent.com/bartoszj/docker-swift-dev/master/docs/swift.png)

Swift is a general-purpose programming language built using a modern approach to safety, performance, and software design patterns.

The goal of the Swift project is to create the best available language for uses ranging from systems programming, to mobile and desktop apps, scaling up to cloud services. Most importantly, Swift is designed to make writing and maintaining correct programs easier for the developer.

> https://swift.org/

# How to use this image

## Build image

To build Debian Jessie image:

```
docker build -t swift-dev:jessie jessie
```

## Build Swift

- Clone Swift repository:

```
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone
```

- Build Swift (using Jessie image):

```
docker run --name swift_jessie -v ${PWD}:/src -v ${PWD}/output:/output --privileged bartoszj/swift-dev:jessie
```

Source code is associated to the host machine via Volume `/src`. The `/output` volume stores compiled Swift package (`swift-${TIMESTAMP}-${BUILD_NAME}.tar.gz`) and build logs (`build-${TIMESTAMP}-${BUILD_NAME}.log`). `--privileged` is required to run some unit tests suites.

### Build tips

- Subsequent builds will reuse build artifacts which can reduce build time:

```
docker start -ai swift_jessie
```

- If you want to save build artifacts and use them in other container you can use `-v swift_build:/build`:

```
docker run --name swift_jessie -v ${PWD}:/src -v ${PWD}/output:/output -v swift_build:/build --privileged bartoszj/swift-dev:jessie
docker run --name swift_xenial -v ${PWD}:/src -v ${PWD}/output:/output -v swift_build:/build --privileged bartoszj/swift-dev:xenial
```

- Building Swift 3 on Ubuntu Xenial:  
    - https://bugs.swift.org/browse/SR-1023 (https://github.com/apple/swift/pull/2609, commit: `3b7b0d80919997ead4c9bb6d681c5739e22d34cc`)
    - https://bugs.swift.org/browse/SR-1631 (https://github.com/apple/swift-corelibs-xctest/pull/120, commit: `eb46e08ba1977252ec576724be14c88d8c51898c`)

# License

```
The MIT License (MIT)

Copyright (c) 2016 Bartosz Janda

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
