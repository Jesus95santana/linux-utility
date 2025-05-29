[[ -n "$ZSH_VERSION" ]] && setopt KSH_ARRAYS


list_removable_mounts() {
    IFS=$'\n'
    mount_points=($(lsblk -o MOUNTPOINT,RM | awk '$2 == 1 && $1 != "" {print $1}'))
    if [[ ${#mount_points[@]} -eq 0 ]]; then
        # Check for first-level dirs under likely mount roots
        user=${USER:-$(whoami)}
        mount_points=(
            $(find /media/$user /run/media/$user /mnt -mindepth 1 -maxdepth 1 -type d 2>/dev/null)
        )
    fi
    unset IFS

    if [[ ${#mount_points[@]} -eq 0 ]]; then
        echo "No removable (USB/SD) drives detected!"
        return 1
    fi

    echo "Available removable drives:"
    choices=()
    idx=0
    for mp in "${mount_points[@]}"; do
        echo "  $idx) $mp"
        choices+=("$mp")
        ((idx++))
    done

    read "sel?Choose a number from the list above: "
    test_dir="${choices[$sel]}"
}


function speed_test {
    list_removable_mounts

    if [[ -z "$test_dir" || ! -d "$test_dir" ]]; then
        echo "Invalid selection or directory!"
        return 1
    fi

    cd "$test_dir" || { echo "Failed to change directory."; return 1; }

    echo "Testing write speed in $test_dir ..."
    dd if=/dev/zero of=testfile bs=1G count=1 oflag=dsync

    # Clear filesystem cache before read test
    echo "Clearing RAM cache (requires sudo)..."
    sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

    echo "Testing read speed in $test_dir ..."
    dd if=testfile of=/dev/null bs=1G count=1 iflag=dsync

    rm testfile
    echo "Speed test completed and testfile removed."
}

