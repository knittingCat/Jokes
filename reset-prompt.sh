#!/bin/sh
# Resets the prompt to the current username.
# Usage: . ./reset-prompt.sh

MARK="# prompt-joke"
RESET_MARK="# prompt-reset"

clean() {
  file="$1"
  prompt="$2"
  touch "$file"
  if grep -q -e "$MARK" -e "$RESET_MARK" "$file"; then
    sed -i.bak "/$MARK/d; /$RESET_MARK/d" "$file"
    echo "Removed old prompt settings from $file (backup at $file.bak)"
  else
    echo "No old prompt settings in $file"
  fi

  printf '\n%s %s\n' "$prompt" "$RESET_MARK" >> "$file"
}

clean "$HOME/.zshrc" "PROMPT='%n@%m %1~ %# '"
clean "$HOME/.bashrc" "PS1='\\u@\\h \\W \\\$ '"

if [ -n "${ZSH_VERSION:-}" ]; then
  PROMPT='%n@%m %1~ %# '
elif [ -n "${BASH_VERSION:-}" ]; then
  PS1='\u@\h \W \$ '
fi

echo "Prompt settings saved; sourcing this script updates the current shell immediately."