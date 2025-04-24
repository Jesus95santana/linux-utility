#!/bin/bash
# Function to check if the given application is installed
function check_installed {
    if command -v "$1" >/dev/null 2>&1; then
        echo "$1 is installed."
    else
        echo "$1 is not installed."
    fi
}
