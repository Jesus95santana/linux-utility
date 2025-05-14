#!/usr/bin/env zsh

# Prompt
echo "Paste your WP‑CLI plugin table below."
echo "When you're done, press Enter then Ctrl‑D."

# Read everything into an array
lines=()
while IFS= read -r line; do
  lines+=("$line")
done

# Print a blank line to separate input from output
echo

# Get today’s date in MM/DD/YY
today=$(date '+%m/%d/%y')

# Process each stored line
for line in "${lines[@]}"; do
  # Skip table borders
  [[ $line == +* ]] && continue
  # Skip the header row
  [[ $line == *name*update_version* ]] && continue
  # Only handle rows starting with |
  [[ $line != \|* ]] && continue

  # Split fields on '|' → field2=name, field7=auto_update
  IFS='|' read -r _ name _ _ _ _ auto_update _ <<< "$line"

  # Trim whitespace
  name=${name##[[:space:]]}
  name=${name%%[[:space:]]}
  auto_update=${auto_update##[[:space:]]}
  auto_update=${auto_update%%[[:space:]]}

  # Choose symbol
  [[ $auto_update == on ]] && symbol='✅' || symbol='❌'

  # Print result
  echo "${name}: ${symbol} ${today}"
done
