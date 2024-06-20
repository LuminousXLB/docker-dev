#!/bin/bash
# https://optee.readthedocs.io/en/latest/building/prerequisites.html

source /etc/os-release
set -ex

apt-get update

if [ "$VERSION_CODENAME" == "focal" ]; then
    apt-get install -y \
        autoconf \
        automake \
        bc \
        bison \
        build-essential \
        ccache \
        cpio \
        cscope \
        curl \
        device-tree-compiler \
        expect \
        flex \
        ftp-upload \
        gdisk \
        git \
        iasl \
        libattr1-dev \
        libcap-ng-dev \
        libfdt-dev \
        libftdi-dev \
        libglib2.0-dev \
        libgmp3-dev \
        libhidapi-dev \
        libmpc-dev \
        libncurses5-dev \
        libpixman-1-dev \
        libslirp-dev \
        libssl-dev \
        libtool \
        make \
        mtools \
        netcat \
        ninja-build \
        python-is-python3 \
        python3-crypto \
        python3-cryptography \
        python3-pip \
        python3-pyelftools \
        python3-serial \
        rsync \
        unzip \
        uuid-dev \
        wget \
        xdg-utils \
        xterm \
        xz-utils \
        zlib1g-dev
    apt-get install -y libgnutls28-dev

elif [ "$VERSION_CODENAME" == "jammy" ]; then
    apt-get install -y \
        acpica-tools \
        autoconf \
        automake \
        bc \
        bison \
        build-essential \
        ccache \
        cpio \
        cscope \
        curl \
        device-tree-compiler \
        e2tools \
        expect \
        fastboot \
        flex \
        ftp-upload \
        gdisk \
        git \
        libattr1-dev \
        libcap-ng-dev \
        libfdt-dev \
        libftdi-dev \
        libglib2.0-dev \
        libgmp3-dev \
        libhidapi-dev \
        libmpc-dev \
        libncurses5-dev \
        libpixman-1-dev \
        libslirp-dev \
        libssl-dev \
        libtool \
        libusb-1.0-0-dev \
        make \
        mtools \
        netcat \
        ninja-build \
        python-is-python3 \
        python3-cryptography \
        python3-pip \
        python3-pyelftools \
        python3-serial \
        rsync \
        swig \
        unzip \
        uuid-dev \
        wget \
        xdg-utils \
        xterm \
        xz-utils \
        zlib1g-dev
    apt-get install -y libgnutls28-dev

else
    echo "Unsupported Ubuntu version: $VERSION_CODENAME"
    exit 1

fi

curl https://storage.googleapis.com/git-repo-downloads/repo >/bin/repo
chmod a+x /bin/repo

rm -rf /var/lib/apt/lists/*
