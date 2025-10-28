#!/bin/sh
#env | grep ^CHEZMOI

# exit immediately if keepassxc is already in $PATH
type keepassxc >/dev/null 2>&1 && exit

if [ -f /etc/os-release ]; then
   source /etc/os-release
else
   exit 1
fi

case $ID in
    arch)
	echo "Installing keepassxc"
        sudo pacman -Sy keepassxc
        ;;
    debian)
        echo "Installing keepassxc"
	sudo apt-get install keepassxc -y
        ;;
    *)
        echo "${ID} is unsupported"
	exit 1
	;;
esac
