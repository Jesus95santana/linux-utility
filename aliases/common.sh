# System Config
alias uefi="systemctl reboot --firmware-setup"

# Networking
alias showip="curl http://ipinfo.io/ip" # Display public IP
alias showlocalip="hostname -I | cut -d' ' -f1" # Display private IP

# Terminal UI
alias shell_config="p10k configure" # PowerLevel10k Edit


# Docker Config
alias dc='docker compose'
alias dnode='docker compose run node'
alias dwp='docker compose run wpcli'
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}"'
alias dcl='docker compose up --remove-orphans -d'

# Shortcuts
alias ll='ls -la'
alias fresh='source ~/.zshrc'
alias datef='mkdir -p "$(date +%Y-%m-%d)"'

