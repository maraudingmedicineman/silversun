#!/usr/bin/env bash

set -euo pipefail

echo -e "\033[1;33mAdding custom bootc parameters to /etc/profile.d...\033[0m"

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

		"rebase" )
		sudo /usr/bin/bootc switch
		return
		;;

		"status" )
		sudo /usr/bin/bootc status
		return
		;;

		"status --booted" )
		sudo /usr/bin/bootc status --booted
		return
		;;

		"update" | "upgrade" )
		sudo /usr/bin/bootc upgrade
		return
		;;

		* )
		command /usr/bin/rpm-ostree "$@"
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

		command /usr/bin/bootc "$@"
		return

        else
		# Mask bootc options so we don't have to prefix with sudo.
		case "$1" in

			status | switch | update | upgrade )
			sudo /usr/bin/bootc "$@"
			return
			;;

			* )
			command /usr/bin/bootc "$@"
			return
			;;

		esac

        fi
    }
fi
EOF

cat << 'EOF' > /etc/sudoers.d/001-bootc
%wheel ALL=(ALL) NOPASSWD: /usr/bin/bootc update, /usr/bin/bootc upgrade, /usr/bin/bootc status, /usr/bin/bootc status --booted
EOF
