#!/bin/zsh
function flush {
    echo "Restarting systemd-resolved..."
sudo systemctl restart systemd-resolved

echo "Flushing DNS cache..."
sudo resolvectl flush-caches

echo "DNS cache flushed and resolver restarted!"
}

