FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN set -x \
    && sed -i.old "s/archive.ubuntu.com/sg.archive.ubuntu.com/g" /etc/apt/sources.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
    build-essential \
    ca-certificates \
    cloud-image-utils \
    curl \
    cpu-checker \
    gdb \
    git \
    less \
    openssh-server \
    pkg-config \
    python3-pip \
    qemu-kvm \
    rsyslog \
    sudo \
    tzdata \
    unzip \
    vim \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN set -x \
    && ssh-keygen -A \
    && echo "" >> /etc/ssh/sshd_config \
    && echo "X11UseLocalhost yes" >> /etc/ssh/sshd_config \
    && mkdir /run/sshd

RUN set -x \
    && sed -i.old '/imklog/d' etc/rsyslog.conf

ARG USER=ubuntu
ARG KVM_GID

# Add user
RUN set -x \
    && groupadd --gid ${KVM_GID} kvm \
    && groupadd --gid 1000 ${USER} \
    && useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${USER} \
    && usermod ${USER} -aG kvm \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

# Start sshd
CMD set -x \
    && ( \
        [ ! -d /data ] \
        || [ -d /data ] \
            && mkdir /home/${USER}/.ssh \
            && cp /data/authorized_keys /home/${USER}/.ssh/authorized_keys \
            && chown -R 1000:1000 /home/${USER}/.ssh \
       )\
    && service ssh start \
    && rsyslogd \
    && tail -f /dev/null
