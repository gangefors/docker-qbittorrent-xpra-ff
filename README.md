# Docker image with qBittorrent, Firefox and Xpra

Xpra can be used to connect to X in the container where qBittorrent and
Firefox will be running. You can also access qBT through it's web UI if
you don't have access to a system running X, but even WSL2 works with
Xpra.

The image is based on `linuxserver/qbittorrent`. Only Xpra, Firefox and
the normal, non-nox, qBittorrent client are added on to of the base.

## Build image

    docker build -t gangefors/qbt .

## Environment variables

See [linuxserver/qbittorrent] for the base env. vars.

This image adds the following env. vars:

- `XPRA_PORT`, default: 3388
  This is the port Xpra server will listen on. This port needs to be published.

- `DISPLAY`, default: 10
  This is the display that Xpra will use. Must be >= 10.

- `FIX_CERT_ISSUES`, default: unset
  If the tracker still haven't upgraded their certificates you can
  lower the TLS protocol and cipher for compatibility. Set it to any
  value to enable.

## Start a container

    docker run -d --name qbt \
        -e PUID=`id -u` \
        -e PGID=`id -g` \
        -e TZ=Europe/Stockholm \
        -e UMASK=022 \
        -e WEBUI_PORT=8080 \
        -p 8080:8080 \
        -p 6881:6881 \
        -p 6881:6881/udp \
        -e XPRA_PORT=3388 \
        -e DISPLAY=10 \
        -e FIX_CERT_ISSUES=y \
        -p 3388:3388 \
        -v $HOME/.config/qbt:/config \
        gangefors/qbt

## Connect to Xpra

Install `xpra` on any Linux system or WSL2. See the [Xpra download]
documentation for additional information.

Connect to the server with:

    xpra attach tcp://192.168.1.12:9988/10 \
        --desktop-scaling=off \
        --speaker=disabled \
        --microphone=disabled


[linuxserver/qbittorrent]: https://github.com/linuxserver/docker-qbittorrent
[Xpra download]: https://github.com/Xpra-org/xpra/wiki/Download
