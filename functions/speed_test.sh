#!/bin/bash
# Function to check read and write speed
function speed_test {
    echo "Testing write speed..."
    dd if=/dev/zero of=testfile bs=1G count=1 oflag=dsync
    echo "Testing read speed..."
    dd if=testfile of=/dev/null bs=1G count=1 iflag=dsync
    rm testfile
}
