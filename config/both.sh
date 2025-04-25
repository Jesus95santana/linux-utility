#!/bin/sh
# This script prints the current date and time.
function both_test() {
    echo "Current Date and Time:"
    if date; then
        echo "✅ Passed"
    else
        echo "❌ Failed"
    fi
}
