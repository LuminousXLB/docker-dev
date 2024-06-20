#!/bin/bash

source /etc/os-release
set -ex

dpkg --add-architecture i386
apt-get update

if [ "$VERSION_CODENAME" == "focal" ]; then
    # https://support.xilinx.com/s/article/000034483?language=en_US
    apt-get install -y \
        autoconf \
        automake \
        bison \
        build-essential \
        chrpath \
        cpio \
        debianutils \
        diffstat \
        flex \
        gawk \
        gcc \
        gcc-multilib \
        git \
        git-core \
        gnupg \
        gzip \
        iproute2 \
        iputils-ping \
        libegl1-mesa \
        libncurses5-dev \
        libsdl1.2-dev \
        libselinux1 \
        libssl-dev \
        libtool \
        make \
        net-tools \
        pax \
        pylint3 \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        screen \
        socat \
        tar \
        texinfo \
        tftpd \
        unzip \
        wget \
        xterm \
        xz-utils \
        zlib1g-dev \
        zlib1g:i386
    apt-get install -y python-is-python3 # replace "python"
    apt-get install -y libtinfo5

elif [ "$VERSION_CODENAME" == "jammy" ]; then
    # https://support.xilinx.com/s/article/000035572?language=en_US
    apt-get install -y \
        autoconf \
        automake \
        bison \
        build-essential \
        chrpath \
        cpio \
        debianutils \
        diffstat \
        flex \
        gawk \
        gcc \
        gcc-multilib \
        git \
        git-core \
        gnupg \
        gzip \
        iproute2 \
        iputils-ping \
        libegl1-mesa \
        libncurses5-dev \
        libsdl1.2-dev \
        libselinux1 \
        libssl-dev \
        libtool \
        make \
        net-tools \
        pax \
        pylint \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        screen \
        socat \
        tar \
        texinfo \
        tftpd \
        unzip \
        wget \
        xterm \
        xz-utils \
        zlib1g-dev \
        zlib1g:i386
    apt-get install -y python-is-python3 # replace "python"
    apt-get install -y libtinfo5

else
    echo "Unsupported Ubuntu version: $VERSION_CODENAME"
    exit 1

fi

ln -sf /bin/bash /bin/sh

rm -rf /var/lib/apt/lists/*
