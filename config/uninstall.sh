#!/bin/zsh

# Dynamic script path detection (Zsh-specific)
script_path="${(%):-%N}"
# Added up one directory
script_dir="$(cd "$(dirname "$script_path")"/.. && pwd)"

source "$script_dir/config/main.sh"


uninstallation_menu() {
    clear
    echo "Uninstall Menu:"
    echo "1. Uninstall to Shell"
    echo "2. Uninstall Oh My Zsh"
    echo "3. Uninstall Powerlevel10k"
    echo "4. Uninstall All"

    while true; do
        echo -n "Select an Uninstall option: "
        read uninstall_choice
        case "$uninstall_choice" in
            1)
                uninstall_from_shell ~/.zshrc
                echo "✅ uninstalled in Shell."
                ;;
            2)
                uninstall_oh_my_zsh
                echo "✅ Oh My Zsh uninstalled."
                ;;
            3)
                uninstall_powerlevel10k
                echo "✅ Powerlevel10k uninstalled."
                ;;
            4)
                uninstall_all
                echo "✅ All components uninstalled."
                ;;
            *)
                echo "Invalid option selected. Please try again."
                ;;
        esac
        echo
        echo -n "Press enter to return to uninstallation Menu..."
        read dummy
    done
}

if [[ "$(basename -- "$0")" == "uninstall.sh" ]]; then
    uninstallation_menu
fi