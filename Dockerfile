FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Remote
/opt/teamviewer/config
RUN \
  echo "**** add icon ****" && \
  curl -o /usr/share/icons/hicolor/128x128/apps/teamviewer.png https://www.teamviewer.com/etc.clientlibs/teamviewer/clientlibs/clientlib-resources/resources/favicon.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends xz-utils desktop-file-utils fonts-noto-cjk-extra && \
  curl -L -o /tmp/teamviewer.deb https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb && \
  apt-get install -y /tmp/teamviewer.deb && \
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
