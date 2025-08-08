if [ $(command -v "keepassxc-cli") ]; then
	alias kp="keepassxc-cli"

#	if [ $(command -v "fd") && $(command -v "fzf") && $(command -v "xsel") ]; then
#	    alias {kp,kpx}=keepassxc_fzf
#	    keepassxc_fzf() {     
#		if [ ! -f "${KPDB}" ];then 
#			KPDB=$(fd kdbx "${HOME}" | fzf --no-hscroll -m --height 50%  --ansi --no-bold --border --header "Choose which database?")
#		fi 
#
#		if [ -z "${KPPW}" ];then
#			echo "Please enter the password for the KeepassX database."
#			read KPPW
#		fi
#
#		clear
#		export KPPW=${KPPW}
#		export KPDB=${KPDB}
#
#		if [ ! -z "${1}" ];then 
#			echo "${KPPW}" | keepassxc-cli show -s "${KPDB}" "${1}" 2> /dev/null
#			exit
#		else
#			SCRIPTNAME=$(realpath "$0")
#			KPVALUE=$(echo "${KPPW}" | keepassxc-cli ls --recursive --flatten "${KPDB}" | fzf --no-hscroll -m --ansi --no-bold --preview="$SCRIPTNAME {}" )
#			echo "${KPPW}" | keepassxc-cli show -s "${KPDB}" "${KPVALUE}" -a password 2> /dev/null | xsel -p ; xsel -o | xsel -b
#			printf "\nThe password is copied to the clipboard.\n"
#			printf "Username is %s\n"  "$(echo "${KPPW}" | keepassxc-cli show -s "${KPDB}" "${KPVALUE}" -a username 2> /dev/null)"
#			printf "TOTP (if existing) is %s"  "$(echo "${KPPW}" | keepassxc-cli show -s "${KPDB}" "${KPVALUE}" --totp 2> /dev/null)"
#		fi
#	    }
#	fi
fi
