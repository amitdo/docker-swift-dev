#! /bin/bash

VERSIONS=("debian:jessie" "debian:stretch" "debian:sid" "ubuntu:trusty" "ubuntu:xenial" "ubuntu:yakkety")
FILES=("build.sh" "swift-build-presets.ini")
TEMPLATE="template"

for version in ${VERSIONS[@]}
do
    base="${version%:*}"
    variant="${version#*:}"

    # Make directory
    mkdir -p "${variant}"

    # Copy Dockerfile
    sed -e "s/^\(FROM\) .*/\\1 ${base}:${variant}/" \
        -e "s/^\(ENV\) BUILD_NAME .*/\\1 BUILD_NAME ${variant}/" \
        "${TEMPLATE}/Dockerfile" > "${variant}/Dockerfile"

    # For Ubuntu Trusty the Clang 3.8 and CMake >= 3.4.3 have to be installed
    if [[ "${variant}" == "trusty" ]]; then
        sed -e "s/clang \\\/clang-3.8 \\\/" \
            -e "s/cmake \\\/make wget \\\/" \
            -e "s_\(/var/lib/apt/lists/\*\)_\\1 \\\ \\
    \&\& wget https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz \\\ \\
    \&\& tar zxvf cmake-3.7.2.tar.gz \\\ \\
    \&\& cd cmake-3.7.2 \\\ \\
    \&\& ./configure \&\& make -j 8 \&\& make install \\\ \\
    \&\& cd ../ \&\& rm -r cmake-3.7.2 \\\ \\
    \&\& update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force \\\ \\
    \&\& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100 \\\ \\
    \&\& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100_" \
            -i "" "${variant}/Dockerfile"
    fi

    # For Debian Jessie CMake >= 3.4.3 have to be installed
    if [[ "${variant}" == "jessie" ]]; then
        sed -e "s/cmake \\\/make wget \\\/" \
            -e "s_\(/var/lib/apt/lists/\*\)_\\1 \\\ \\
    \&\& wget https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz \\\ \\
    \&\& tar zxvf cmake-3.7.2.tar.gz \\\ \\
    \&\& cd cmake-3.7.2 \\\ \\
    \&\& ./configure \&\& make -j 8 \&\& make install \\\ \\
    \&\& cd ../ \&\& rm -r cmake-3.7.2 \\\ \\
    \&\& update-alternatives --install /usr/bin/cmake cmake /usr/local/bin/cmake 1 --force_" \
            -i "" "${variant}/Dockerfile"
    fi

    # For Debian Stretch and Sid the Clang 3.8, Swig 3.0.7, libedit 3.1-20150325-1 have to be installed
    if [[ "${variant}" == "stretch" || "${variant}" == "sid" ]]; then
        sed -e "s/clang \\\/clang-3.8 \\\/" \
            -e "s/swig \\\/wget \\\/" \
            -e "s_\(/var/lib/apt/lists/\*\)_\\1 \\\ \\
    \&\& wget http://snapshot.debian.org/archive/debian/20160617T164513Z/pool/main/s/swig/swig\_3.0.7-2.1\_amd64.deb \\\ \\
    \&\& wget http://snapshot.debian.org/archive/debian/20160617T164513Z/pool/main/s/swig/swig3.0\_3.0.7-2.1\_amd64.deb \\\ \\
    \&\& wget http://snapshot.debian.org/archive/debian/20151204T042531Z/pool/main/libe/libedit/libedit2\_3.1-20150325-1%2Bb1\_amd64.deb \\\ \\
    \&\& wget http://snapshot.debian.org/archive/debian/20151204T042531Z/pool/main/libe/libedit/libedit-dev\_3.1-20150325-1%2Bb1\_amd64.deb \\\ \\
    \&\& dpkg -i *deb \&\& rm *deb \\\ \\
    \&\& update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100 \\\ \\
    \&\& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100_" \
            -i "" "${variant}/Dockerfile"
    fi

    # Copy script and ocnfig files
    for file in ${FILES[@]}
    do
        cp "${TEMPLATE}/${file}" "${variant}/"
    done
done
