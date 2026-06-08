# Keymaps

**Leader key = `Space`.** Most custom shortcuts start with it.

> "Normal mode" = the default command mode. Press `Esc` to return to it from typing.

## Files & saving
| Keys | Action |
|------|--------|
| `Space w` | Save file |
| `Space q` | Quit window |
| `:w` | Save (built-in) |
| `:wq` / `:x` | Save and quit |
| `:q!` | Quit without saving |

## Editing essentials (built-in Vim)
| Keys | Action |
|------|--------|
| `i` / `a` | Insert before / after cursor |
| `o` / `O` | New line below / above + insert |
| `Esc` | Back to Normal mode |
| `u` | Undo |
| `Ctrl + r` | Redo |
| `dd` | Delete (cut) a line |
| `yy` | Copy a line |
| `p` / `P` | Paste after / before |
| `x` | Delete a character |
| `v` / `V` / `Ctrl+v` | Visual select: char / line / block |

## Movement
| Keys | Action |
|------|--------|
| `h j k l` | left / down / up / right |
| `w` / `b` | next / previous word |
| `0` / `$` | start / end of line |
| `gg` / `G` | top / bottom of file |
| `42G` | go to line 42 |
| `Ctrl+d` / `Ctrl+u` | half-page down / up (centered) |
| `/text` + Enter | search (`n` next, `N` previous) |
| `Ctrl+o` / `Ctrl+i` | jump back / forward (history) |

## Windows / splits
| Keys | Action |
|------|--------|
| `Ctrl + h/j/k/l` | move to window left/down/up/right |
| `Ctrl + Up/Down` | resize height |
| `Ctrl + Left/Right` | resize width |
| `:split` / `:vsplit` | horizontal / vertical split |

## File explorer (nvim-tree)
| Keys | Action |
|------|--------|
| `Space e` | Toggle the sidebar |
| `a` | Create file (folder: end name with `\` on Windows) |
| `d` | Delete |
| `r` | Rename |
| `x` / `c` / `p` | Cut / copy / paste |
| `R` | Refresh tree |
| `Enter` | Open file / expand folder |
| `?` | Show all explorer keybindings |

## Fuzzy finder (Telescope)
| Keys | Action |
|------|--------|
| `Space ff` | Find files |
| `Space fg` | Grep text across project |
| `Space fb` | Switch open buffers |
| `Space fr` | Recent files |
| `Space fh` | Help tags |

## Code intelligence (LSP — in .ts/.js/etc. files)
| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Find all references (where it's used) |
| `gi` | Go to implementation |
| `K` | Hover docs / type info |
| `Space rn` | Rename symbol everywhere |
| `Space ca` | Code action (quick fix / import) |
| `[d` / `]d` | Previous / next diagnostic (error) |
| `Space d` | Show diagnostic message under cursor |

## Formatting (Prettier via conform.nvim)
| Keys | Action |
|------|--------|
| `Space cf` | Format file (or visual selection) |
| _(auto)_ | Formats automatically on save |

## Autocomplete (Insert mode)
| Keys | Action |
|------|--------|
| `Ctrl + Space` | Trigger completion menu |
| `Tab` / `Shift+Tab` | Next / previous suggestion |
| `Enter` | Accept suggestion |
| `Ctrl + e` | Dismiss menu |

## Misc
| Keys | Action |
|------|--------|
| `Esc` | Clear search highlight |
| `J` / `K` (visual) | Move selected lines down / up |
| `<` / `>` (visual) | Indent left / right (keeps selection) |
