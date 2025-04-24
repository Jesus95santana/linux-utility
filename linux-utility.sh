#!/bin/bash

for alias_file in $(dirname "$0")/aliases/*.sh; do
    source $alias_file
done

for script in $(dirname "$0")/config/*.sh; do
    source $script
done

for script in $(dirname "$0")/functions/*.sh; do
    source $script
done

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