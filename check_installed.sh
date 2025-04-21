#!/bin/bash

# Define a function to check if a given program is installed
check_installed() {
    if command -v $1 >/dev/null 2>&1; then
        echo "$1 is installed."
    else
        echo "$1 is not installed."
    fi
}
