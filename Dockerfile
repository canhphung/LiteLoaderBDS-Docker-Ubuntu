# ----------------------------------
# LiteladerBDS Core
# Environment: LiteLoaderBDS
# Minimum Panel Version: 1.x.x
# ----------------------------------
FROM ubuntu:18.04

LABEL Pterodactyl Software, <support@pterodactyl.io>

ENV BDSDIR /home/container/bds/
ENV BDSVER 1.18.2.03
ENV LLVER 2.0.3

RUN apt update
RUN adduser --disabled-password --home /home/container container 
RUN apt install wget software-properties-common unzip apt-transport-https ca-certificates -y
RUN dpkg --add-architecture i386
RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN apt-key add winehq.key
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
RUN wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/amd64/libfaudio0_19.07-0~bionic_amd64.deb
RUN wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/i386/libfaudio0_19.07-0~bionic_i386.deb
RUN dpkg -i libfaudio0_19.07-0~bionic_amd64.deb libfaudio0_19.07-0~bionic_i386.deb
RUN apt install winehq-stable
RUN wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip
RUN wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader-${LLVER}.zip
RUN wget https://github.com/canhphung/LiteLoaderBDS-Docker-v2/raw/main/vcruntime140_1.zip
RUN unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR}
RUN unzip LiteLoader-${LLVER}.zip -d ${BDSDIR}

COPY vcruntime140_1.zip ${BDSDIR}

USER container

ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
