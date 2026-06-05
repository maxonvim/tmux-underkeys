# tmux-underkeys

![tmux-underkeys demo](assets/demo.gif)

Visible mnemonic keys for instant tmux session switching.

`tmux-underkeys` underlines one unique character in each session name and binds a trigger key so you can jump directly to that session.

## Why

- Sessions are always visible in the status line, so switching does not require
  opening or listing sessions.
- Switching is reduced to two inputs: trigger key, then the displayed character.
- The mapping is stable as long as session names stay the same, so keys do not
  change unexpectedly.
- Adding more sessions only adds more characters to the status line, rather than more
  steps to switch.
- No need to remember session positions or reorder-dependent shortcuts.

## Installation

With TPM:

```tmux
set -g @plugin 'maxonvim/tmux-underkeys'
```

Choose your trigger key before the plugin line if you do not want the default `C-g`:

```tmux
set -g @underkeys-trigger 'M-s'
set -g @plugin 'maxonvim/tmux-underkeys'
```

The plugin adds the underkey session list to `status-right` automatically.

## Usage

Press the trigger key, then the underlined session key.

Default trigger:

```text
C-g
```

Example:

```text
C-g o
```

Switches to the session whose underlined key is `o`.

## Options

```tmux
set -g @underkeys-trigger 'C-g'
set -g @underkeys-table 'underkeys'
set -g @underkeys-status 'on'
set -g @underkeys-position 'right'
set -g @underkeys-separator ' '
set -g @underkeys-sort 'created'
set -g @underkeys-current-style 'fg=blue,bold'
set -g @underkeys-style 'fg=white'
```

Set `@underkeys-status` to `off` if you want to place the status segment yourself.

Set `@underkeys-sort` to `created`, `name`, or `tmux` to choose the session order used for key assignment.

## How Keys Are Picked

Sessions are processed by creation time by default so new sessions do not shift existing keys.

For each session, the first unused alphanumeric character in the session name becomes its key.

For example:

```text
app   -> a
api   -> p
admin -> d
notes -> n
```
