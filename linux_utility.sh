# Cross-shell dynamic script detection
if [ -n "$BASH_SOURCE" ]; then
    script_path="${BASH_SOURCE[0]}"
elif [ -n "$ZSH_VERSION" ]; then
    script_path="${(%):-%N}"
else
    script_path="$0"
fi

# Correct dynamic path detection
script_dir="$(cd "$(dirname "$script_path")" && pwd)"



source "$script_dir/uninstall.sh"
source "$script_dir/install.sh"

# Counters
alias_count=0
function_count=0

# Load aliases
if compgen -G "$script_dir/aliases/*.sh" > /dev/null; then
    for alias_file in "$script_dir"/aliases/*.sh; do
        if [ -f "$alias_file" ]; then
            source "$alias_file"
            ((alias_count++))
        fi
    done
fi

# Load functions
if compgen -G "$script_dir/functions/*.sh" > /dev/null; then
    for function_file in "$script_dir"/functions/*.sh; do
        if [ -f "$function_file" ]; then
            source "$function_file"
            ((function_count++))
        fi
    done
fi

# Print summary
echo "✅ Loaded $alias_count alias file(s)"
echo "✅ Loaded $function_count function file(s)"


menu() {
    clear
    echo "Please select an option:"
    echo "1. Install Zsh, Oh My Zsh, Powerlevel10k, and set Zsh as default"
    echo "2. Uninstall Zsh, Oh My Zsh, and Powerlevel10k"
    echo "3. Only set Zsh as default shell"
    echo "4. Show IP and Private IP"
    echo "5. Disk Speed Test"
    echo "6. Exit"
    read -p "Enter your choice: " choice
    case "$choice" in
        1)
            install_all
            echo "✅ Installation complete. Please restart your terminal."
            ;;
        2)
            uninstall_all
            echo "✅ Uninstallation complete. Please restart your terminal."
            ;;
        3)
            set_default_zsh  # Set Zsh as default without installing/uninstalling anything else
            ;;
        4) show_ips ;;
        5) disk_speed_test ;;
        6) echo "Exiting..."; break ;;
        *) echo "Invalid option selected. Exiting." ;;
    esac
    echo
    read -p "Press enter to continue..."
    clear
}

# Direct call to the menu function if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    menu
fi