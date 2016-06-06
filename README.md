# docker-swift-dev
[![Travis](https://img.shields.io/travis/bartoszj/docker-swift-dev.svg?maxAge=2592000)](https://travis-ci.org/bartoszj/docker-swift-dev)

Set of Docker images used to compile Swift compiler.

## Build image:

```
docker build -t swift-dev .
```

## Build Swift:

- Clone Swift repository:
```
git clone https://github.com/apple/swift.git
./swift/utils/update-checkout --clone
```
- Build Swift:
```
docker run --rm -v ${PWD}:/swift --privileged swift-dev
```
