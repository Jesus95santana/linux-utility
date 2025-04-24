diskbench() {
  echo "Available drives:"
  lsblk -d -o NAME,SIZE,ROTA,TYPE,MOUNTPOINT,MODEL | grep -v loop
  echo
  read -p "Enter the drive (e.g. sda, sdb): " drive

  # Find a mounted partition on the selected drive
  mountpoint=$(lsblk -o NAME,SIZE,ROTA,TYPE,MOUNTPOINT,MODEL -nr /dev/"$drive" | awk '$2 != "" {print $2; exit}')

  if [ -z "$mountpoint" ]; then
    echo "No mounted partitions found on /dev/$drive."
    return 1
  fi

  testfile="$mountpoint/diskbench_testfile"

  echo
  echo "Testing WRITE speed on /dev/$drive at $mountpoint..."
  dd if=/dev/zero of="$testfile" bs=1G count=1 oflag=dsync status=progress

  echo
  echo "Testing READ speed..."
  dd if="$testfile" of=/dev/null bs=1G count=1 iflag=dsync status=progress

  echo
  echo "Cleaning up test file..."
  rm -f "$testfile"
}
