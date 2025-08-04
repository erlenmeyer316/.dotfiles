if [ $(command -v "fzf") ]; then
    eval "$(fzf --bash)"

    if [ $(command -v "rg") ]; then
        export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi

fi
