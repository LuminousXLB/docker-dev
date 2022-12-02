FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

# install common packages
RUN set -x \
    && sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/sg.archive.ubuntu.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        bear \
        build-essential \
        curl \
        git \
        htop \
        locales \
        openssh-server \
        python3-pip \
        rsync \
        rsyslog \
        sudo \
        tzdata \
        unzip \
        vim \
        xauth \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir cmake

# set locale timezone and
RUN set -x \
    && echo "en_SG.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# prepare sshd
RUN set -x \
    && ssh-keygen -A \
    && mkdir /run/sshd \
    && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config \
    && echo "X11UseLocalhost no" >> /etc/ssh/sshd_config

# install petlinux dependencies
RUN set -x \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y \
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
        less \
        libegl1-mesa \
        libncurses5-dev \
        libsdl1.2-dev \
        libselinux1 \
        libssl-dev \
        libtinfo5 \
        libtool \
        make \
        net-tools \
        pax \
        pylint3 \
        python \
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
        zlib1g-dev \
        zlib1g:i386 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir ninja meson \
    && ln -sf /bin/bash /bin/sh

# install optee depenedncies
RUN set -x \
    && apt-get update \
    && sudo apt install -y \
        # android-tools-adb \
        # android-tools-fastboot \
        autoconf \
        automake \
        bc \
        bison \
        build-essential \
        ccache \
        cscope \
        curl \
        device-tree-compiler \
        expect \
        flex \
        ftp-upload \
        gdisk \
        iasl \
        libattr1-dev \
        libcap-dev \
        libfdt-dev \
        libftdi-dev \
        libglib2.0-dev \
        libgmp3-dev \
        libhidapi-dev \
        libmpc-dev \
        libncurses5-dev \
        libpixman-1-dev \
        libssl-dev \
        libtool \
        make \
        mtools \
        netcat \
        ninja-build \
        python3-crypto \
        python3-cryptography \
        python3-pip \
        python3-pyelftools \
        python3-serial \
        rsync \
        unzip \
        uuid-dev \
        xdg-utils \
        xterm \
        xz-utils \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Get REPO
RUN set -x \
    && export REPO=$(mktemp /tmp/repo.XXXXXXXXX) \
    && curl -o ${REPO} https://storage.googleapis.com/git-repo-downloads/repo \
    && gpg --recv-key 8BB9AD793E8E6153AF0F9A4416530D5E920F5C65 \
    && curl -s https://storage.googleapis.com/git-repo-downloads/repo.asc | gpg --verify - ${REPO} \
    && install -m 755 ${REPO} /usr/local/bin/repo

# add default user
ARG USER=ubuntu
RUN set -x \
    && groupadd --gid 1000 ${USER} \
    && useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

USER ${USER}
RUN set -x \
    && ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -N '' \
    && [ ! -f /tools/Xilinx/PetaLinux/2021.1/settings.sh ] || echo "source /tools/Xilinx/PetaLinux/2021.1/settings.sh" >> ~/.bashrc

COPY --chown=1000:1000 authorized_keys /home/${USER}/.ssh/

USER root

CMD set -x \
    && service rsyslog start \
    && service ssh start \
    && tail -f /dev/null
