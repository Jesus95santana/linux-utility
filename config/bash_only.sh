#!/bin/bash
# This uses a bash-specific feature: array slicing
function bash_test() {
    my_array=(apple banana cherry)
    # Attempt to slice the array and capture the output
    result=$(echo ${my_array[@]:1:2})
    
    if [ -n "$result" ]; then  # Check if result is not empty
        echo $result
        echo "✅ Passed"
    else
        echo "❌ Failed"
    fi
}