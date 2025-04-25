# Bash Specific Aliases
if [ -n "$BASH_VERSION" ]; then
    alias fresh="source ~/.bashrc"
    alias uninstall-linux-utility="bash \"$script_dir/uninstall.sh\""
fi