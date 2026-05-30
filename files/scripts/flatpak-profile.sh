#!/usr/bin/env bash

set -eou pipefail

cat << 'EOF' > /etc/profile.d/unsupported.sh
# Silversun is per-user focused, so system-wide flatpak operations are unsupported.
flatpak()
{
	# Preserve tab-completion even with unsupported options.
	if [[ -n "${COMP_LINE-}" || -n "${COMP_POINT-}" ]]; then

		command /usr/bin/flatpak "$@"
		return

	fi
	# Politely warn user of unsupported actions.
	case " $@ " in
	# Spaces are there so argument positions are respected.
		*" --system "* )
		echo "Unsupported:'--system'"
		return
		;;

	esac
}
EOF
