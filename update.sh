#! /bin/bash

VERSIONS=("debian:jessie" "debian:stretch" "debian:sid" "ubuntu:trusty" "ubuntu:wily" "ubuntu:xenial")
FILES=("build.sh" "swift-build-presets")
TEMPLATE="template"

for version in ${VERSIONS[@]}
do
    base="${version%:*}"
    variant="${version#*:}"

    # Make directory.
    mkdir -p "${variant}"

    # Copy Dockerfile.
    sed -e "s/^\(FROM\) .*/\\1 ${base}:${variant}/" \
        -e "s/^\(ENV\) BUILD_NAME .*/\\1 BUILD_NAME ${variant}/" \
        "${TEMPLATE}/Dockerfile" > "${variant}/Dockerfile"

    if [[ "${variant}" == "trusty" ]]; then
        sed -e "s/clang \\\/clang-3.6 \\\/" \
            -e "s_/var/lib/apt/lists/\*_/var/lib/apt/lists/\* \\\ \\
    \&\& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 \\\ \\
    \&\& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100_" \
            -i "" "${variant}/Dockerfile"
    fi

    # Copy script and ocnfig files.
    for file in ${FILES[@]}
    do
        cp "${TEMPLATE}/${file}" "${variant}/"
    done
done
