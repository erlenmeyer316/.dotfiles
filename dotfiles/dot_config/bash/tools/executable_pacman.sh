if [ $(command -v "pacman") ]; then
    alias installed-packages="sudo pacman -Qqe"
    alias system-update="sudo pacman -Syu"

    if [ $(command -v "fzf") ]; then
        alias pacinstall="pacman -Sql | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
	alias pacuninstall="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
    fi


fi
