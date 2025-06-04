#!/bin/zsh

# DEBUG MODE (set to 1 for debug, or pass --debug as an argument)
DEBUG=0
for arg in "$@"; do
    [[ "$arg" == "--debug" ]] && DEBUG=1
done

debug_echo() {
    [[ "$DEBUG" -eq 1 ]] && echo "[DEBUG] $@"
}

# Dynamic script path detection (Zsh-specific)
script_path="${(%):-%N}"
script_dir="$(cd "$(dirname "$script_path")" && pwd)"

source "$script_dir/config/main.sh"

# Counters for loaded files
alias_count=0
function_count=0

# Load aliases
alias_files=("$script_dir"/aliases/*.sh)
if (( #alias_files )); then
    for alias_file in $alias_files; do
        if [ -f "$alias_file" ]; then
            source "$alias_file"
            ((alias_count++))
        fi
    done
else
    echo "No alias files found to load."
fi

# Load functions
function_files=("$script_dir"/functions/*.sh)
if (( #function_files )); then
    for function_file in $function_files; do
        if [ -f "$function_file" ]; then
            source "$function_file"
            ((function_count++))
        fi
    done
else
    echo "No function files found to load."
fi

# Print summary
debug_echo "✅ Loaded $alias_count alias file(s)"
debug_echo "✅ Loaded $function_count function file(s)"
debug_echo "All aliases and functions loaded."


menu() {
    while true; do
        clear
        echo "Please select an option:"
        echo "0. Debug: show loaded aliases/functions"
        echo "1. Installation"
        echo "2. Uninstall Zsh, Oh My Zsh, and Powerlevel10k"
        echo "3. Only set Zsh as default shell"
        echo "4. Show IP and Private IP"
        echo "5. Disk Speed Test"
        echo "6. Sync Folder (rsync, watches for changes)"
        echo "7. Exit"
        echo -n "Enter your choice: "
        read choice
        case "$choice" in
            0)
                echo
                echo "🔍  Loaded alias files ($alias_count):"
                for f in "${alias_files[@]}"; do echo "   • $f"; done
                echo
                echo "🔍  Loaded function files ($function_count):"
                for f in "${function_files[@]}"; do echo "   • $f"; done
                echo
                echo -n "Press enter to continue…" ; read _
                ;;
            1)
                installation_menu
                ;;
            2)
                uninstall_all
                echo "✅ Uninstallation complete. Please restart your terminal."
                ;;
            3)
                set_default_zsh
                ;;
            4)
                show_ips
                ;;
            5)
                speed_test
                ;;
            6)
                echo "Enter source folder:"
                read src
                echo "Enter destination folder:"
                read dst
                sync_folder "$src" "$dst"
                echo -n "Press enter to continue…" ; read _
                ;;
            7)
                echo "Exiting..."
                break
                ;;
            *)
                echo "Invalid option selected. Please try again."
                ;;
        esac
        echo
        echo -n "Press enter to continue..."
        read dummy
        clear
    done
}

installation_menu() {
    clear
    echo "Installation Menu:"
    echo "1. Install to Shell"
    echo "2. Install Oh My Zsh"
    echo "3. Install Powerlevel10k"
    echo "4. Install All"
    echo "5. Return to Main Menu"

    while true; do
        echo -n "Select an installation option: "
        read install_choice
        case "$install_choice" in
            1)
                install_to_shell ~/.zshrc
                echo "✅ Installed in Shell."
                ;;
            2)
                install_oh_my_zsh
                echo "✅ Oh My Zsh installed."
                ;;
            3)
                install_powerlevel10k
                echo "✅ Powerlevel10k installed."
                ;;
            4)
                install_all
                echo "✅ All components installed."
                ;;
            5)
                break
                ;;
            *)
                echo "Invalid option selected. Please try again."
                ;;
        esac
        echo
        echo -n "Press enter to return to Installation Menu..."
        read dummy
    done
}

# if [[ "$(basename -- "$0")" == "linux_utility.sh" ]]; then
#     menu
# fi
