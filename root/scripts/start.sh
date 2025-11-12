#!/bin/bash

if [[ -n "$PUID" && -n "$PGID" ]]; then
    chown -R $PUID:$PGID /opt/teamviewer
fi
