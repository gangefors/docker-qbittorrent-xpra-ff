FROM linuxserver/qbittorrent

ARG DEBIAN_FRONTEND="noninteractive"
RUN curl -sS https://xpra.org/gpg.asc | apt-key add - && \
    . /etc/os-release; echo "deb https://xpra.org/ ${UBUNTU_CODENAME} main" \
        > /etc/apt/sources.list.d/xpra.list && \
    apt-get update && apt-get install -y \
        firefox \
        qbittorrent \
        xpra \
    && rm -rf /var/lib/apt/lists/*
COPY root/ /
