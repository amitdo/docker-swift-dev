#! /bin/bash

VERSIONS=("debian:jessie" "debian:stretch" "debian:sid" "ubuntu:trusty" "ubuntu:wily" "ubuntu:xenial")
FILES=("build.sh" "swift-build-presets")
TEMPLATE="template"

for version in ${VERSIONS[@]}
do
    base="${version%:*}"
    variant="${version#*:}"

    # Copy Dockerfile.
    sed -e "s/^\(FROM\) .*/\\1 ${base}:${variant}/" \
        -e "s/^\(ENV\) BUILD_NAME .*/\\1 BUILD_NAME ${variant}/" \
        "${TEMPLATE}/Dockerfile" > "${variant}/Dockerfile"

    # Copy script and ocnfig files.
    for file in ${FILES[@]}
    do
        cp "${TEMPLATE}/${file}" "${variant}/"
    done
done
