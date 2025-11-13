#!/bin/bash

nohup tint2 > /dev/null 2>&1 &

if [[ -n "$PUID" && -n "$PGID" ]]; then
    sudo chown -R $PUID:$PGID /opt/teamviewer
fi
