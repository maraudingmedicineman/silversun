#!/usr/bin/env bash
set -eou pipefail

FEDORA_RELEASE="f$(rpm -E %fedora)"

echo -e "\033[1;33mSetting default background...\033[0m"

cat <<- EOF > /usr/share/glib-2.0/schemas/zz0-silversun.gschema.override
[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'
picture-uri-dark='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'

[org.gnome.screensaver]
picture-uri='file:///usr/share/backgrounds/${FEDORA_RELEASE}/default/${FEDORA_RELEASE}.xml'
EOF
