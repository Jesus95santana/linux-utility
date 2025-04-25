# Alias to display public IP
alias showip="curl http://ipinfo.io/ip"
# Alias to display private IP
alias showlocalip="hostname -I | cut -d' ' -f1"

# Zsh Specific Aliases
if [ -n "$ZSH_VERSION" ]; then
    alias fresh="source ~/.zshrc"

# Bash Specific Aliases
elif [ -n "$BASH_VERSION" ]; then
    alias fresh="source ~/.bashrc"
fi