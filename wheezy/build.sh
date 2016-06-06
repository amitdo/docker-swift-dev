#! /bin/bash

# Some Swift branches require to have configured Git.
git config --global user.email "swift@example.com"
git config --global user.name "Swift Build Bot"

# Variables
BUILD_NAME=${BUILD_NAME:+_$BUILD_NAME}
export SWIFT_BUILD_ROOT="/swift_build"
SWIFT_PRESET_FILE="/swift_build/swift-build-presets"
SWIFT_PRESET="swift_build"
SWIFT_INSTALL_DESTDIR="/swift/install${BUILD_NAME}"
SWIFT_INSTALL_PACKAGGE="/swift/swift${BUILD_NAME}.tar.gz"

# Build
/swift/swift/utils/build-script \
  --preset-file="${SWIFT_PRESET_FILE}" \
  --preset-file="/swift/swift/utils/build-presets.ini" \
  --preset="${SWIFT_PRESET}" \
  install_destdir="${SWIFT_INSTALL_DESTDIR}" \
  installable_package="${SWIFT_INSTALL_PACKAGGE}"
