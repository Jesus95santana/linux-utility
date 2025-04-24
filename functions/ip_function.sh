#!/bin/bash

# Function to show public IP
show_public_ip() {
    echo "Public IP: $(curl -s http://ipinfo.io/ip)"
}

# Function to show private IP
show_private_ip() {
    echo "Private IP: $(hostname -I | cut -d' ' -f1)"
}

# Combined function to show both IPs
show_ips() {
    show_public_ip
    show_private_ip
}
