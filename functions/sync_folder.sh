sync_folder() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: sync_folder <source_folder> <destination_folder>"
        return 1
    fi

    local source="$1"
    local dest="$2"

    if [[ ! -d "$source" ]]; then
        echo "❌ Error: Source folder does not exist."
        return 1
    fi

    if [[ ! -d "$dest" ]]; then
        echo "ℹ️ Destination does not exist. Creating it..."
        mkdir -p "$dest" || { echo "❌ Failed to create destination."; return 1; }
    fi

    echo "🔄 Syncing from '$source' to '$dest'..."
    echo "🕵️ Watching for changes. Press Ctrl+C to stop."

    while inotifywait -r -e modify,create,delete,move "$source" >/dev/null 2>&1; do
        rsync -rtv --human-readable --delete --inplace "$source/" "$dest/"
        if [[ $? -eq 0 ]]; then
            echo "✅ Sync successful at $(date '+%T')"
        else
            echo "❌ Sync failed at $(date '+%T')"
        fi
    done
}
