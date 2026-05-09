#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

trigger_key='M-s'
key_table='underkeys'

tmux set-option -gq '@underkeys-dir' "$CURRENT_DIR"
tmux bind-key -n "$trigger_key" switch-client -T "$key_table" \; display-message 'underkeys'

for key in {a..z} {0..9}; do
  tmux bind-key -T "$key_table" "$key" run-shell "$CURRENT_DIR/scripts/underkeys switch '$key'"
done
