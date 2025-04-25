#!/bin/bash

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

# Get the absolute path
script_dir="$(cd "$(dirname "$script_path")" && pwd)"
linux_utility_path="${script_dir}/linux_utility.sh"

# Function to remove from a shell config
function uninstall_from_shell {
    local config_file=$1

    if [[ -f "$config_file" && -w "$config_file" ]]; then
        # Remove the source line
        sed -i "\|source \"$linux_utility_path\"|d" "$config_file"

        # Remove the linux alias
        sed -i "/alias linux=/d" "$config_file"

        echo "✅ Removed linux_utility entries from $config_file"
    else
        echo "❌ Cannot modify $config_file (does not exist or not writable)"
    fi
}

# Uninstall from both .bashrc and .zshrc
uninstall_from_shell ~/.bashrc
uninstall_from_shell ~/.zshrc

echo "✅ Uninstall complete. You may restart your terminal."
