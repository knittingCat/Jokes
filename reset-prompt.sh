#!/bin/sh
# Removes the prompt lines added by set-prompt.sh.
# Usage: sh reset-prompt.sh

MARK="# prompt-joke"

clean() {
  file="$1"
  if [ -f "$file" ] && grep -q "$MARK" "$file"; then
    # delete any line tagged with the marker
    sed -i.bak "/$MARK/d" "$file"
    echo "Removed from $file (backup at $file.bak)"
  else
    echo "Nothing to remove in $file"
  fi
}

clean "$HOME/.zshrc"
clean "$HOME/.bashrc"

echo "Open a new terminal window to see the default prompt return."