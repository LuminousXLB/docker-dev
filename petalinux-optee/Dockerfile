ARG CODENAME
ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:${CODENAME}

# update apt sources
RUN sed -i 's/http:\/\/archive.ubuntu.com/http:\/\/mirror.sg.gs/g' /etc/apt/sources.list

# install base packages
RUN set -x \
    && apt-get update \
    && apt-get install -y locales \
    && echo "en_SG.UTF-8 UTF-8" >>/etc/locale.gen \
    && echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen \
    && locale-gen \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && yes | unminimize \
    && apt-get install -y \
        build-essential \
        curl \
        git \
        htop \
        libssl-dev \
        openssh-server \
        pkgconf \
        python3-pip \
        rsync \
        sudo \
        time \
        tmux \
        unzip \
        vim \
    && pip3 install --no-cache-dir cmake \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# install bear
COPY setup/build-bear.sh .
RUN ./build-bear.sh && rm -rf /tmp/*

# install dependencies for OP-TEE
COPY setup/deps-optee.sh .
RUN ./deps-optee.sh && rm -rf /tmp/*

# install dependencies for PetaLinux
COPY setup/deps-petalinux.sh .
RUN ./deps-petalinux.sh && rm -rf /tmp/*

# configure SSH server
RUN set -x \
    && ssh-keygen -A \
    && mkdir /run/sshd \
    && echo "PasswordAuthentication no" >>/etc/ssh/sshd_config \
    && echo "X11UseLocalhost no" >>/etc/ssh/sshd_config

# configure bash completion
RUN echo 'set completion-ignore-case on' >>/etc/inputrc

# add default user
ARG USER=ubuntu
RUN set -x \
    && groupadd --gid 1000 ${USER} \
    && useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

USER ${USER}

# install SSH authorized keys
RUN ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -N ''
COPY --chown=1000:1000 authorized_keys /home/${USER}/.ssh/

# install zoxide
RUN set -x \
    && curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh \
    && echo 'eval "$(zoxide init bash)"' >>~/.profile

# source PetaLinux settings on login
COPY setup/envs-petalinux.sh /tmp/envs-petalinux.sh
RUN /tmp/envs-petalinux.sh

USER root
CMD service ssh start && tail -f /dev/null
