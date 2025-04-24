# #!/bin/bash

# # Get the absolute path of the directory where the script resides
# script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
# script_path="${script_dir}/linux-utility.sh"

# # Function to add source line to a shell config file if it doesn't already exist
# function add_source_line {
#     local config_file=$1
#     local line="source $script_path"

#     # Check if the file exists and is writable
#     if [[ -f "$config_file" && -w "$config_file" ]]; then
#         # Check if the line already exists in the file
#         if ! grep -Fxq "$line" "$config_file"; then
#             echo "$line" >> "$config_file"
#             echo "Added source entry to $config_file"
#         else
#             echo "Source entry already exists in $config_file"
#         fi
#     else
#         echo "Error: $config_file does not exist or is not writable."
#     fi
# }

# # Add the source line to both .bashrc and .zshrc
# add_source_line ~/.bashrc
# add_source_line ~/.zshrc

# echo "Setup complete. Please restart your terminal."

#!/bin/bash

# Define the path to the utility script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
script_path="${script_dir}/linux-utility.sh"

# Function to add an alias to a shell config file
function add_alias_line {
    local config_file=$1
    local alias_name="linux"
    local alias_command="bash ${script_path}"

    # Check if the file exists and is writable
    if [[ -f "$config_file" && -w "$config_file" ]]; then
        # Remove existing alias to avoid duplicates
        sed -i "/alias ${alias_name}=/d" "$config_file"
        # Add new alias
        echo "alias ${alias_name}='${alias_command}'" >> "$config_file"
        echo "Added or updated alias '${alias_name}' in ${config_file}"
    else
        echo "Error: ${config_file} does not exist or is not writable."
    fi
}

# Add or update the alias in both .bashrc and .zshrc
add_alias_line ~/.bashrc
add_alias_line ~/.zshrc

echo "Setup complete. Please restart your terminal."
