#!/bin/sh
# Adds a custom prompt to ~/.zshrc and ~/.bashrc.
# Usage: . ./prank-prompt.sh [name]   (default name: hacker)
# Undo:  sed -i '' '/# prompt-joke/d' ~/.zshrc ~/.bashrc

NAME="${1:-hacker}"
MARK="# prompt-joke"

add() {
  file="$1"
  line="$2"
  touch "$file"
  if grep -q "$MARK" "$file"; then
    echo "Already set prank prompt"
  else
    printf '\n%s %s\n' "$line" "$MARK" >> "$file"
  fi
}

add "$HOME/.zshrc"  "PROMPT='$NAME@%m %1~ %# '"
add "$HOME/.bashrc" "PS1='$NAME@\\h \\W \\\$ '"
PROMPT="$NAME@%m %1~ %# "
PS1="$NAME@\\h \\W \\\$ "

echo "Prompt settings saved; sourcing this script updates the current shell immediately."