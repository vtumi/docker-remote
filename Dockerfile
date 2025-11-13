FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Remote

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends xz-utils tint2 desktop-file-utils fonts-noto-cjk-extra && \
  apt-get install -y --no-install-recommends libdbus-1-3 libqt5gui5 libqt5widgets5 libqt5qml5 libqt5quick5 libqt5webkit5 libqt5x11extras5 qml-module-qtquick2 qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick-layouts && \
  curl -L -o /tmp/teamviewer.tar.xz https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.tar.xz && \
  tar xvfJ /tmp/teamviewer.tar.xz -C /tmp && \
  mv /tmp/teamviewer /opt && \
  ln -s /opt/teamviewer/tv_bin/script/teamviewer /usr/bin/teamviewer && \
  rm -rf /tmp/teamviewer.tar.xz && \
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
