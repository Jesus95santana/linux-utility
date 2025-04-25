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

# Install into .bashrc and .zshrc
install_to_shell ~/.bashrc
install_to_shell ~/.zshrc

echo "✅ Setup complete. Please restart your terminal."