#!/bin/zsh

# Dynamic script path detection (Zsh-specific)
script_path="${(%):-%N}"
# Added up one directory
script_dir="$(cd "$(dirname "$script_path")"/.. && pwd)"

source "$script_dir/config/main.sh"


installation_menu() {
    clear
    echo "Installation Menu:"
    echo "1. Install to Shell"
    echo "2. Install Oh My Zsh"
    echo "3. Install Powerlevel10k"
    echo "4. Install All"

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
            *)
                echo "Invalid option selected. Please try again."
                ;;
        esac
        echo
        echo -n "Press enter to return to Installation Menu..."
        read dummy
    done
}

if [[ "$(basename -- "$0")" == "install.sh" ]]; then
    installation_menu
fi
