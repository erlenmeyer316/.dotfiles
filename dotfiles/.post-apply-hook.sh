#!/bin/sh
#env | grep ^CHEZMOI

if [ -f "$HOME/.bash_profile" ]; then
    eval "$(source $HOME/.bash_profile)"
    echo "Refreshed bash session"
fi
