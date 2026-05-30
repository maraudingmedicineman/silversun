#!/usr/bin/env bash

set -euo pipefail

cat << 'EOF' > /etc/profile.d/bootc-override.sh
rpm-ostree()
{
	# Preserve tab-completion.
	if [[ -n "${COMP_LINE-}" || -n "${COMP_POINT-}" ]]; then

		command /usr/bin/rpm-ostree "$@"
		return

	fi
	# Mask rpm-ostree options with bootc equivalents.
	case "$@" in

		rebase ) bootc switch
		return
		;;

		update | upgrade ) bootc upgrade
		return
		;;

	esac

}

export -f rpm-ostree
EOF

cat << 'EOF' > /etc/profile.d/bootc.sh
if [[ "$EUID" -ne 0 ]]; then
    bootc() {
	# Keep otherwise normal.
        if [[ "$EUID" -eq 0 ]]; then

            /usr/bin/bootc "$@"

        else
		# Mask bootc options so we don't have to prefix with sudo.
		case "$1" in

			status | update | upgrade ) sudo /usr/bin/bootc "$@" ;;

			* ) /usr/bin/bootc "$@" ;;

		esac

        fi
    }
fi
EOF

cat << 'EOF' > /etc/sudoers.d/001-bootc
%wheel ALL=(ALL) NOPASSWD: /usr/bin/bootc update, /usr/bin/bootc upgrade, /usr/bin/bootc status, /usr/bin/bootc status --booted
EOF
