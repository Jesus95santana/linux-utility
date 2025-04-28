# Detect current script path dynamically
if [ -n "$BASH_SOURCE" ]; then
    # In Bash
    script_path="${BASH_SOURCE[0]}"
elif [ -n "$ZSH_VERSION" ]; then
    # In Zsh
    script_path="${(%):-%N}"
else
    # Fallback
    script_path="$0"
fi

# Get the absolute path of the linux_utility.sh
script_dir="$(cd "$(dirname "$script_path")" && pwd)"

script_path="${script_dir}/linux_utility.sh"

# Function to modify shell configs
function install_to_shell {
    local config_file=$1
    local source_line="source \"$script_path\""
    local alias_line="alias linux='menu'"

    if [[ -f "$config_file" && -w "$config_file" ]]; then
        # Add the source line if it doesn't already exist
        if ! grep -Fxq "$source_line" "$config_file"; then
            echo "$source_line" >> "$config_file"
            echo "✅ Added sourcing of linux_utility.sh to $config_file"
        else
            echo "ℹ️ Already sourcing linux_utility.sh in $config_file"
        fi

        # Add the 'linux' alias (optional: points to menu function)
        sed -i "/alias linux=/d" "$config_file"
        echo "$alias_line" >> "$config_file"
        echo "✅ Added alias 'linux' to $config_file"
    else
        echo "❌ Cannot write to $config_file"
    fi
}


# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Oh My Zsh installed successfully."
    else
        echo "Oh My Zsh is already installed."
    fi
}

# Function to install Powerlevel10k
install_powerlevel10k() {
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        echo "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        echo "Powerlevel10k installed successfully."
        # Set Powerlevel10k theme in .zshrc
        sed -i '/ZSH_THEME=/c\ZSH_THEME="powerlevel10k/powerlevel10k"' $HOME/.zshrc
    else
        echo "Powerlevel10k is already installed."
    fi
}

install_meslolgs_nf() {
    echo "Installing MesloLGS NF Font..."
    mkdir -p "$HOME/.local/share/fonts"
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Regular.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Italic.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    curl -fLo "$HOME/.local/share/fonts/MesloLGS NF Bold Italic.ttf" \
        "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
    # Refresh the font cache
    fc-cache -f -v
    echo "MesloLGS NF Font installed successfully."
}

set_default_zsh() {
    if [ -n "$(command -v zsh)" ]; then
        echo "Setting Zsh as the default shell..."
        chsh -s "$(command -v zsh)"
        echo "Default shell set to Zsh."
    else
        echo "Zsh is not installed, cannot set as default shell."
    fi
}

install_all() {
    install_to_shell ~/.zshrc
    install_oh_my_zsh
    install_powerlevel10k
    install_meslolgs_nf
    set_default_zsh
    echo "✅ Setup complete. Please restart your terminal."
}