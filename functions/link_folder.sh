link_folder() {
    # Check if enough arguments are passed
    if [[ $# -ne 2 ]]; then
        echo "Usage: link_folder <source_folder> <target_link>"
        return 1
    fi

    local source_folder=$1
    local target_link=$2

    # Check if the source directory exists
    if [[ ! -d "$source_folder" ]]; then
        echo "Error: Source directory does not exist."
        return 1
    fi

    # Create the symbolic link
    ln -s "$source_folder" "$target_link"
    if [[ $? -eq 0 ]]; then
        echo "Symbolic link created successfully."
    else
        echo "Failed to create symbolic link."
        return 1
    fi
}
