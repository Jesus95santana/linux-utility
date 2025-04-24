#!/bin/bash
# Function to create a tar.gz archive of a given directory
function create_tar {
    tar -czvf "$1.tar.gz" "$1"
}
