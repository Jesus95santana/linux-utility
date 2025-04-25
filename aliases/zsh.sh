# Zsh Specific Aliases
if [ -n "$ZSH_VERSION" ]; then
    alias fresh="source ~/.zshrc"
    alias uninstall-linux-utility="bash \"$script_dir/uninstall.sh\""
fi