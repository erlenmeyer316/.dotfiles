#!/bin/sh
# env | grep ^CHEZMOI

# exit immediately if keepassxc is already in $PATH
type keepassxc-cli >/dev/null 2>&1 && exit

if [ -f /etc/os-release ]; then
   source /etc/os-release
else
   exit 1
fi

case $ID in
    arch)
        sudo pacman -Sy keepassxc
        ;;
    *)
        echo "${ID} is unsupported"
	exit 1
