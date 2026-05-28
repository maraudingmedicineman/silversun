#!/usr/bin/env bash
set -eoux pipefail

cat <<- "EOF" > /usr/share/glib-2.0/schemas/zz0-silversun.gschema.override
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/f$(rpm -E %fedora)/default/f$(rpm -E %fedora).xml'
picture-uri-dark='file:///usr/share/backgrounds/f$(rpm -E %fedora)/default/f$(rpm -E %fedora).xml'

[org.gnome.screensaver]
picture-uri='file:///usr/share/backgrounds/f$(rpm -E %fedora)/default/f$(rpm -E %fedora).xml'
EOF
