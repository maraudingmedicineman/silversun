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
