FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

RUN apt update \
    && apt install -y \
        build-essential \
        crossbuild-essential-mipsel \
        curl \
        gdb-multiarch \
        git \
        libglib2.0-dev \
        ninja-build \
        python3-pip \
        sudo \
        tmux \
        tzdata \
        vim \
        wget \
        zsh \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && wget https://download.qemu.org/qemu-8.1.0.tar.xz \
    && tar xvJf qemu-8.1.0.tar.xz \
    && cd qemu-8.1.0 \
    && ./configure --target-list=mipsel-linux-user \
    && make install -j$(nproc) \
    && cd .. \
    && rm -rf qemu-8.1.0

# Set timezone
RUN set -x \
    && ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

# Add user
RUN set -x \
    && groupadd --gid 1000 shenjm \
    && useradd --create-home --uid 1000 --gid 1000 --shell /bin/zsh shenjm \
    && echo "shenjm ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

USER shenjm
RUN set -x \
    && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && sed -i "s/robbyrussell/eastwood/g" /home/shenjm/.zshrc

RUN set -x \
    && wget -P ~ https://git.io/.gdbinit \
    && pip install pygments \
    && echo "set auto-load safe-path /" >> /home/shenjm/.gdbinit

CMD tail -f /dev/null
