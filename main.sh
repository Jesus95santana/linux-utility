#!/bin/bash

# Source files
source check_installed.sh
source benchmarks.sh

# Check for multiple utilities
check_installed "neofetch"
check_installed "htop"
check_installed "curl"

diskbench
