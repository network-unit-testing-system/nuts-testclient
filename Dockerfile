FROM ubuntu
ARG S6_OVERLAY_VERSION=3.1.5.0

RUN mkdir -p /run/sshd && \
    useradd -rm -d /home/admin -s /bin/bash -g root -G sudo -u 1000 admin 
ENV ADMIN_PASSWORD=""

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    xz-utils \
    python3 \
    python3-pip \
    telnet \
    tcpdump \
    htop \
    nmap \
    net-tools \
    curl \
    wget \
    vim \
    iperf3 \
    dnsutils \
    tshark \
    iproute2 \
    iputils-ping \
    isc-dhcp-client \
    apache2 \
    traceroute \
    netcat \
    openssh-server \
    snmp \
    snmpd \
    wpasupplicant \
    dhcping \
    jc

RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -Jxpf - -C /  && \
	curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-i686.tar.xz | tar -Jxpf - -C /
ADD s6-rc.d /etc/s6-overlay/s6-rc.d
ADD setup_sshd.sh setup_sshd.sh

ENTRYPOINT ["/init"]


# see all original env vars in all processes
ENV S6_KEEP_ENV=1

EXPOSE 22 

# USER admin

CMD [ "/bin/bash" ]