#! /bin/bash

# Some Swift branches require to have configured Git.
git config --global user.email "swift@example.com"
git config --global user.name "Swift Build Bot"

# Variables
BUILD_NAME=${BUILD_NAME:+-$BUILD_NAME}
TIMESTAMP=`date +"%Y%m%d-%H%M%S"`
SWIFT_INSTALL_DESTDIR="/build/install-${TIMESTAMP}${BUILD_NAME}"
SWIFT_INSTALL_PACKAGGE="/output/swift-${TIMESTAMP}${BUILD_NAME}.tar.gz"
SWIFT_BUILD_LOG="/output/build-${TIMESTAMP}${BUILD_NAME}.log"

# Build
/src/swift/utils/build-script \
  --preset-file="/build_scripts/swift-build-presets" \
  --preset-file="/src/swift/utils/build-presets.ini" \
  --preset="swift_build" \
  install_destdir="${SWIFT_INSTALL_DESTDIR}" \
  installable_package="${SWIFT_INSTALL_PACKAGGE}" \
  2>&1 | tee "${SWIFT_BUILD_LOG}"
