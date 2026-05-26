# tmux-underkeys

Visible mnemonic keys for instant tmux session switching.

`tmux-underkeys` underlines one unique character in each session name and binds a trigger key so you can jump directly to that session.

```text
_a_pp a_p_i a_d_min _n_otes
M-s a -> app
M-s p -> api
M-s d -> admin
M-s n -> notes
```

## Installation

With TPM:

```tmux
set -g @plugin 'maxonvim/tmux-underkeys'
```

The plugin adds the underkey session list to `status-right` automatically.

During local develpment, load the plugin directly:

```tmux
run-shell /path/to/tmux-underkeys/tmux-underkeys.tmux
```

## Usage

Press `M-s`, then the underlined session key.

Example:

```text
M-s o
```

Switches to the session whose underlined key is `o`.

## Options

```tmux
set -g @underkeys-trigger 'M-s'
set -g @underkeys-table 'underkeys'
set -g @underkeys-status 'on'
set -g @underkeys-position 'right'
set -g @underkeys-separator ' '
set -g @underkeys-current-style 'fg=blue,bold'
set -g @underkeys-style 'fg=white'
```
