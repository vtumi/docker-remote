FROM ghcr.io/linuxserver/baseimage-selkies:ubuntunoble

# title
ENV TITLE=Remote

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends iputils-ping netcat-openbsd sshpass xz-utils tint2 desktop-file-utils fonts-noto-cjk-extra && \
  apt-get install -y --no-install-recommends libdbus-1-3 libqt5gui5 libqt5widgets5 libqt5qml5 libqt5quick5 libqt5webkit5 libqt5x11extras5 qml-module-qtquick2 qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick-layouts && \
  curl -L -o /tmp/teamviewer.tar.xz https://download.teamviewer.com/download/linux/version_13x/teamviewer_amd64.tar.xz && \
  tar xvfJ /tmp/teamviewer.tar.xz -C /tmp && \
  mv /tmp/teamviewer /opt && \
  ln -s /opt/teamviewer/tv_bin/script/teamviewer /usr/bin/teamviewer && \
  curl -L -o /tmp/scrcpy.tar.gz $(curl -s https://api.github.com/repos/Genymobile/scrcpy/releases | grep browser_download_url | grep 'scrcpy-linux-x86_64-.*.tar.gz' | head -n 1 | cut -d '"' -f 4) && \
  tar zxvf /tmp/scrcpy.tar.gz -C /tmp && \
  mv /tmp/scrcpy-linux-x86_64-* /opt/scrcpy && \
  ln -s /opt/scrcpy/adb /usr/bin/adb && \
  ln -s /opt/scrcpy/scrcpy /usr/bin/scrcpy && \
  mkdir -p /opt/chromium && \
  curl -L -o /tmp/chromium.tar.gz "https://github.com/vtumi/docker-chromium/releases/download/v1.0.0/chromium-linux.tar.gz" && \
  tar zxvf /tmp/chromium.tar.gz -C /tmp && \
  mv /tmp/chromium/* /opt/chromium/ && \
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
