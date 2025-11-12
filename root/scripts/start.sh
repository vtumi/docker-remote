#!/bin/bash

if [[ -n "$PUID" && -n "$PGID" ]]; then
    sudo chown -R $PUID:$PGID /opt/teamviewer
fi
