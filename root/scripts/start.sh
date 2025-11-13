#!/bin/bash

# configure openbox dock mode for stalonetray
if [ ! -f /config/.config/openbox/rc.xml ] || grep -A20 "<dock>" /config/.config/openbox/rc.xml | grep -q "<noStrut>no</noStrut>"; then
    mkdir -p /config/.config/openbox
    [ ! -f /config/.config/openbox/rc.xml ] && cp /etc/xdg/openbox/rc.xml /config/.config/openbox/
    sed -i '/<dock>/,/<\/dock>/s/<noStrut>no<\/noStrut>/<noStrut>yes<\/noStrut>/' /config/.config/openbox/rc.xml
    openbox --reconfigure
fi

# update openbox menu if differs from default
if [ ! -f /config/.config/openbox/menu.xml ] || ! cmp /defaults/menu.xml /config/.config/openbox/menu.xml; then
    mkdir -p /config/.config/openbox
    cp /defaults/menu.xml /config/.config/openbox/menu.xml
    openbox --reconfigure
fi

nohup stalonetray --dockapp-mode simple > /dev/null 2>&1 &

if [[ -n "$PUID" && -n "$PGID" ]]; then
    sudo chown -R $PUID:$PGID /opt/teamviewer
fi
