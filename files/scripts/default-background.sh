#!/usr/bin/env bash
set -eoux pipefail

FEDORA_RELEASE="f$(rpm -E %fedora)"

cat <<- "EOF" > /usr/share/glib-2.0/schemas/zz0-silversun.gschema.override
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'
picture-uri-dark='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'

[org.gnome.screensaver]
picture-uri='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'
EOF
