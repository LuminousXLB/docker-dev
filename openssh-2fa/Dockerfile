FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

# install dependencies
RUN sed -i 's/archive.ubuntu.com/sg.archive.ubuntu.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y \
        autoconf \
        build-essential \
        libpam-google-authenticator \
        libpam0g-dev \
        libssl-dev \
        libtool \
        pkg-config \
        rsyslog \
        sudo \
        zlib1g-dev

# create user
ARG USER=ubuntu
RUN set -x \
    && groupadd --gid 1000 ${USER} \
    && useradd --create-home --uid 1000 --gid 1000 --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

# install openssh
COPY ./openssh-portable /root/openssh-portable
WORKDIR /root/openssh-portable
RUN autoreconf \
    && ./configure --prefix=/usr --sysconfdir=/etc/ssh --with-pam --with-privsep-path=/var/lib/sshd \
    && make -j$(nproc) \
    && make install \
    && useradd sshd

# configure pam
RUN echo "" >/etc/pam.d/sshd \
    && echo "auth required pam_google_authenticator.so debug" >>/etc/pam.d/sshd

# configure rsyslog
RUN sed -i '/imklog/d' /etc/rsyslog.conf

# configure sshd
RUN echo "UsePAM yes" >>/etc/ssh/sshd_config \
    && echo "PasswdUsePam no" >>/etc/ssh/sshd_config \
    && echo "KbdInteractiveAuthentication yes" >>/etc/ssh/sshd_config \
    && echo "PasswordAuthentication yes" >>/etc/ssh/sshd_config \
    && echo "AuthenticationMethods publickey,keyboard-interactive password,keyboard-interactive" >>/etc/ssh/sshd_config

COPY --chown=ubuntu:ubuntu ./google_authenticator /home/${USER}/.google_authenticator
COPY --chown=ubuntu:ubuntu ./authorized_keys /home/${USER}/.ssh/authorized_keys
COPY ./shadow /etc/shadow

CMD set -e \
    && touch /var/log/auth.log \
    && chown syslog:adm /var/log/auth.log \
    && /usr/sbin/rsyslogd \
    && /usr/sbin/sshd -e \
    && tail -f /var/log/auth.log
