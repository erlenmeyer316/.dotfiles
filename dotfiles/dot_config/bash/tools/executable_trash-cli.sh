
if [ $(command -v "trash") ]; then
    if [ $(command -v "shtab") ]; then
       eval "$(trash --print-completion bash)"
    fi
fi
