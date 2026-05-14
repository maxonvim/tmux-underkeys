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
status_enabled="$(underkeys_option '@underkeys-status' 'on')"
status_command="#($CURRENT_DIR/scripts/underkeys status '#S')"

tmux set-option -gq '@underkeys-dir' "$CURRENT_DIR"

if [[ $status_enabled != 'off' ]]; then
  current_status="$(tmux show-option -gqv status-right 2>/dev/null || true)"
  tmux set-option -gq status-right "$current_status $status_command"
fi

tmux bind-key -n "$trigger_key" switch-client -T "$key_table" \; display-message 'underkeys'

for key in {a..z} {0..9}; do
  tmux bind-key -T "$key_table" "$key" run-shell "$CURRENT_DIR/scripts/underkeys switch '$key'"
done
