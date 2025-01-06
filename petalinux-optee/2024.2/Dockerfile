ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:noble

RUN set -x \
    && sed -i 's/archive.ubuntu.com/sg.archive.ubuntu.com/g' /etc/apt/sources.list.d/ubuntu.sources \
    && apt-get update \
    && apt-get install -y unminimize locales tzdata \
    && echo "en_SG.UTF-8 UTF-8" >>/etc/locale.gen \
    && echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen \
    && locale-gen \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get install -y \
        build-essential \
        cmake \
        pkgconf \
    && apt-get install -y \
        curl \
        git \
        htop \
        openssh-server \
        python3-pip \
        rsync \
        sudo \
        time \
        tmux \
        unzip \
        vim

RUN set -x \
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
        libncurses5-dev \
        libsdl1.2-dev \
        libselinux1 \
        libssl-dev \
        libtool \
        make \
        net-tools \
        pax \
        python3 \
        python3-git \
        python3-jinja2 \
        python3-pexpect \
        python3-pip \
        screen \
        socat \
        tar \
        xterm \
        texinfo \
        unzip \
        wget \
        xz-utils \
        zlib1g-dev \
    && apt-get install -y \
        bc \
    && ln -sf /bin/bash /bin/sh

# RUN set -x \
#     && dpkg --add-architecture i386 \
#     && apt-get update \
#     && apt-get install -y zlib1g:i386 \
#         pylint3 \
#         libegl1-mesa \
#         tftpd

#

# configure SSH server
RUN set -x \
    && ssh-keygen -A \
    && mkdir /run/sshd \
    && echo "PasswordAuthentication no" >>/etc/ssh/sshd_config \
    && echo "X11UseLocalhost no" >>/etc/ssh/sshd_config

# configure bash completion
RUN echo 'set completion-ignore-case on' >>/etc/inputrc

# add default user
ARG USER
RUN set -x \
    && usermod --login ${USER} --move-home --home /home/${USER} ubuntu \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

USER ${USER}

# install SSH authorized keys
RUN set -x \
    && mkdir -p /home/${USER}/.ssh \
    && chmod 700 /home/${USER}/.ssh \
    && curl https://github.com/LuminousXLB.keys -o /home/${USER}/.ssh/authorized_keys \
    && chmod 600 /home/${USER}/.ssh/authorized_keys

# install zoxide
RUN set -x \
    && curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh \
    && echo 'eval "$(zoxide init bash)"' >>~/.profile

USER root
CMD service ssh start && tail -f /dev/null
