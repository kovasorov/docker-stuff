FROM ubuntu:xenial

WORKDIR /opt

COPY scripts/ /opt

RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y bzip2 \
                                         expect \
                                         iproute2 \
                                         iptables \
                                         iputils-ping \
                                         kmod \
                                         libstdc++5:i386 \
                                         libpam0g:i386 \
                                         libx11-6:i386 \
                                         net-tools \
                                         openssh-server && \
    mkdir /var/run/sshd && \
    bash -x snx_install.sh

CMD ["/opt/snx.sh"]