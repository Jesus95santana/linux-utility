search_history_and_run() {
    # Ask user what to search
    read -rp "Search history for: " search_term

    # Show matching history lines
    history | grep --color=always -i "$search_term"

    echo
    read -rp "Enter the command number to execute, or 'q' to quit: " cmd_input

    # If user types 'q' or 'Q', exit
    if [[ "$cmd_input" == "q" || "$cmd_input" == "Q" ]]; then
        echo "Canceled."
        return
    fi

    # If user entered a number
    if [[ "$cmd_input" =~ ^[0-9]+$ ]]; then
        echo "Running command #$cmd_input..."
        eval "$(history | grep -E "^[ ]*$cmd_input" | sed -E 's/^[ ]*[0-9]+[ ]+//')"
    else
        echo "Invalid input. Exiting."
    fi
}
