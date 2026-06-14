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
