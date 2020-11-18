FROM ubuntu:20.04

ARG MERLIN_BASE_VERSION=v0.9.0-beta
ARG MERLIN_FILE_NAME=merlinAgent-Linux-x64.7z
ARG SURICATA_VERSION=5.0.3

RUN apt-get update &&\
    apt-get install -y wget \
        software-properties-common &&\
    wget -qO-  https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - &&\
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list &&\
    apt-get update &&\
    apt-get install -y apt-transport-https \
        lsb-release \
        gnupg2 \
        p7zip-full \
        vim \
        tcpdump \
        netcat \
        net-tools \
        libpcre3 \
        libpcre3-dbg \
        libpcre3-dev \
        build-essential \
        libpcap-dev \
        libnet1-dev \
        libyaml-0-2 \
        libyaml-dev \
        pkg-config \
        zlib1g \
        zlib1g-dev \
        libcap-ng-dev \
        libcap-ng0 \
        make \
        libmagic-dev \
        libjansson-dev \
        libnss3-dev \
        libgeoip-dev \
        liblua5.1-dev \
        libhiredis-dev \
        libevent-dev \
        python-yaml \
        rustc \
        cargo &&\
    apt-get update

WORKDIR /src
RUN wget https://www.openinfosecfoundation.org/download/suricata-${SURICATA_VERSION}.tar.gz &&\
    	tar zxf suricata-${SURICATA_VERSION}.tar.gz;

WORKDIR /src/suricata-${SURICATA_VERSION}

RUN ./configure \
        --disable-shared \
        --disable-gccmarch-native \
        --enable-lua \
        --prefix=/usr/ \
        --sysconfdir=/etc \
        --localstatedir=/var

RUN make &&\
    make install install-conf

RUN mkdir -p /opt/merlin /var/log/merlin
WORKDIR /opt/merlin
RUN wget https://github.com/Ne0nd0g/merlin/releases/download/${MERLIN_BASE_VERSION}/${MERLIN_FILE_NAME} &&\
    7za x -pmerlin ${MERLIN_FILE_NAME} &&\
    rm -rf "${MERLIN_FILE_NAME}"

COPY /init_scripts/ /init_scripts/
RUN chmod +x /init_scripts/*

COPY /misc/suricata.rules /etc/suricata/rules/suricata.rules

COPY /misc/ /tmp/

ENTRYPOINT ["/init_scripts/entrypoint.sh"]
