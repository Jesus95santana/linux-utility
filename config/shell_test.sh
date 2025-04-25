#!/bin/bash
# Script to test other scripts in different shell environments.

function shell_test() {
    echo "Which script would you like to test? (bash_only.sh, zsh_only.sh, both.sh)"
    read script_name

    # Check if the file exists in the config folder
    script_path="./config/$script_name"
    if [ ! -f "$script_path" ]; then
        echo "Script does not exist. Please check the filename and try again."
        return
    fi

    # Define the shells to test
    declare -A shells
    shells=(["bash"]="bash" ["zsh"]="zsh" ["sh"]="sh")

    # Test the script in each shell
    for shell in "${!shells[@]}"; do
        if $shell "$script_path" > /dev/null 2>&1; then
            echo "$shell ✅ Passed"
        else
            echo "$shell ❌ Failed"
        fi
    done
}

