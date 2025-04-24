#!/bin/bash

# Check if the shell is Zsh
if [ -n "$ZSH_VERSION" ]; then
    echo "Hello Zsh"

# Check if the shell is Bash
elif [ -n "$BASH_VERSION" ]; then
    echo "Hello Bash"
fi
