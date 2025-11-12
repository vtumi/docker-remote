FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Remote

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends xz-utils desktop-file-utils fonts-noto-cjk-extra && \
  curl -L -o /tmp/teamviewer.deb https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb && \
  dpkg -i /tmp/teamviewer.deb && \
  apt-get install -f && \
  rm -rf /tmp/teamviewer.deb && \
  fc-cache -fv && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
