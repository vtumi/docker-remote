FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Remote

RUN \
  echo "**** add icon ****" && \
  curl -o /usr/share/icons/hicolor/128x128/apps/teamviewer.png https://www.teamviewer.com/etc.clientlibs/teamviewer/clientlibs/clientlib-resources/resources/favicon.png && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends xz-utils desktop-file-utils fonts-noto-cjk-extra && \
  apt-get install -y --no-install-recommends libdbus-1-3 libqt5gui5 libqt5widgets5 libqt5qml5 libqt5quick5 libqt5webkit5 libqt5x11extras5 qml-module-qtquick2 qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick-layouts && \
  mkdir -p /opt/teamviewer/config && \
  curl -L -o /tmp/teamviewer.deb https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.deb && \
  dpkg -i /tmp/teamviewer.deb && \
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
