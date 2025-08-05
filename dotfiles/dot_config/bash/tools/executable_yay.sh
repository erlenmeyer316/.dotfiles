if [ $(command -v "yay") ]; then
    alias yay-installed-packages="yay -Qqe"
    alias yay-system-update="yay -Syu"

    if [ $(command -v "fzf") ]; then
        alias yayinstall="yay -Sql | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
	alias yayuninstall="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"
    fi
fi
