#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

underkeys_option() {
  local option=$1
  local default=$2
  local value

  value="$(tmux show-option -gqv "$option" 2>/dev/null || true)"

  if [[ -n $value ]]; then
    printf '%s' "$value"
  else
    printf '%s' "$default"
  fi
}

trigger_key="$(underkeys_option '@underkeys-trigger' 'M-s')"
key_table="$(underkeys_option '@underkeys-table' 'underkeys')"
style_current="$(underkeys_option '@underkeys-current-style' 'fg=blue,bold')"
style_other="$(underkeys_option '@underkeys-style' 'fg=white')"
status_enabled="$(underkeys_option '@underkeys-status' 'on')"
status_position="$(underkeys_option '@underkeys-position' 'right')"
status_separator="$(underkeys_option '@underkeys-separator' ' ')"
status_command="#($CURRENT_DIR/scripts/underkeys status '#S' '$style_current' '$style_other')"

tmux set-option -gq '@underkeys-dir' "$CURRENT_DIR"

if [[ $status_enabled != 'off' ]]; then
  status_option="status-$status_position"
  current_status="$(tmux show-option -gqv "$status_option" 2>/dev/null || true)"

  if [[ $current_status != *'/scripts/underkeys status'* ]]; then
    if [[ $status_position == 'left' ]]; then
      tmux set-option -gq "$status_option" "$status_command$status_separator$current_status"
    else
      tmux set-option -gq "$status_option" "$current_status$status_separator$status_command"
    fi
  fi
fi

tmux bind-key -n "$trigger_key" switch-client -T "$key_table" \; display-message 'underkeys'
tmux bind-key -T "$key_table" Escape switch-client -T root
tmux bind-key -T "$key_table" C-c switch-client -T root

for key in {a..z} {0..9}; do
  tmux bind-key -T "$key_table" "$key" run-shell "$CURRENT_DIR/scripts/underkeys switch '$key'"
done
