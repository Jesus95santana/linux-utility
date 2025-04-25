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

# Load config (optional: no counting here unless you want to)
if compgen -G "$script_dir/config/*.sh" > /dev/null; then
    for config_file in "$script_dir"/config/*.sh; do
        [ -f "$config_file" ] && source "$config_file"
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
    while true; do
        echo "Please select an option:"
        echo "1. Show IP and Private IP"
        echo "2. Disk Speed Test"
        echo "3. Exit"
        read -p "Enter your choice: " choice

        case "$choice" in
            1) show_ips ;;
            2) disk_speed_test ;;
            3) echo "Exiting..."; break ;;
            *) echo "Invalid option. Please try again." ;;
        esac
        echo
        read -p "Press enter to continue..."
        clear
    done
}

# Direct call to the menu function if not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    menu
fi