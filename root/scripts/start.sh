#!/bin/bash

if [ ! -f /config/.config/openbox/rc.xml ] || grep -q '<application class="\*">.*<maximized>yes</maximized>' /config/.config/openbox/rc.xml; then
    mkdir -p /config/.config/openbox
    [ ! -f /config/.config/openbox/rc.xml ] && cp /etc/xdg/openbox/rc.xml /config/.config/openbox/
    sed -i '/<application class="\*">/,/<\/application>/s/<maximized>yes<\/maximized>/<maximized>no<\/maximized>/' /config/.config/openbox/rc.xml
    openbox --reconfigure
fi

if [ ! -f /config/.config/openbox/menu.xml ] || ! cmp /defaults/menu.xml /config/.config/openbox/menu.xml; then
    mkdir -p /config/.config/openbox
    cp /defaults/menu.xml /config/.config/openbox/menu.xml
    openbox --reconfigure
fi

if [ ! -f /config/.config/tint2/tint2rc ]; then
    mkdir -p /config/.config/tint2
    cp /etc/xdg/tint2/tint2rc /config/.config/tint2/tint2rc
    sed -i 's/^panel_items = .*/panel_items = T/' /config/.config/tint2/tint2rc
    sed -i 's/^panel_position = .*/panel_position = top center horizontal/' /config/.config/tint2/tint2rc
    sed -i 's/^taskbar_name = .*/taskbar_name = 0/' /config/.config/tint2/tint2rc
fi

nohup tint2 > /dev/null 2>&1 &

if [[ -n "$PUID" && -n "$PGID" ]]; then
    sudo chown -R $PUID:$PGID /opt/teamviewer
fi
