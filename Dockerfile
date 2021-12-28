# ----------------------------------
# LiteladerBDS Core
# Environment: LiteLoaderBDS
# Minimum Panel Version: 1.x.x
# ----------------------------------
FROM ubuntu:grovy

LABEL Pterodactyl Software, <support@pterodactyl.io>

ENV BDSDIR /home/container/bds/
ENV BDSVER 1.18.2.03
ENV LLVER 2.0.3

RUN apt update && \
 adduser --disabled-password --home /home/container container && \
 apt install apt-transport-https ca-certificates -y && \
 apt install wget -y && \
 apt install software-properties-common -y &&\
 apt install unzip -y && \
 dpkg --add-architecture i386 && \
 wget -nc https://dl.winehq.org/wine-builds/winehq.key && apt-key add winehq.key && \
 add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ grovy main' && \
 apt update && apt install winehq-stable -y && \
 wget https://minecraft.azureedge.net/bin-win/bedrock-server-${BDSVER}.zip && \
 wget https://github.com/LiteLDev/LiteLoaderBDS/releases/download/${LLVER}/LiteLoader-${LLVER}.zip && \
 wget https://github.com/canhphung/LiteLoaderBDS-Docker-v2/raw/main/vcruntime140_1.zip && \
 unzip bedrock-server-${BDSVER}.zip -d ${BDSDIR} && \
 unzip LiteLoader-${LLVER}.zip -d ${BDSDIR}

COPY vcruntime140_1.zip ${BDSDIR}
RUN unzip vcruntime140_1.zip "vcruntime140_1.dll" && \
wine SymDB2.exe && \
rm vcruntime140_1.zip

USER container

ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
