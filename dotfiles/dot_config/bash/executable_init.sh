[[ -f "$HOME/.config/bash/config.sh" ]] && . "$HOME/.config/bash/config.sh"
[[ -f "$HOME/.config/bash/aliases.sh" ]] && . "$HOME/.config/bash/aliases.sh"
[[ -f "$HOME/.config/bash/functions.sh" ]] && . "$HOME/.config/bash/functions.sh"
[[ -f "$HOME/.config/bash/prompt.sh" ]] && . "$HOME/.config/bash/prompt.sh"
[[ -f "$HOME/.config/bash/path.sh" ]] && . "$HOME/.config/bash/path.sh"
[[ -f "$HOME/.config/bash/theme-dracula.sh" ]] && . "$HOME/.config/bash/theme-dracula.sh"

for file in $HOME/.config/bash/tools/*.sh; do
    . "$file"
done
