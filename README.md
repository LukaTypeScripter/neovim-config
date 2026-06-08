# My Neovim config

Personal Neovim setup. Theme: **Catppuccin Mocha**. Plugin manager: **lazy.nvim**.
Plugin versions are pinned in `lazy-lock.json` for reproducible installs across machines.

## Setting up on a new device

### 1. Install Neovim + external tools
These are NOT managed by this repo — install them first.

**Windows (winget):**
```powershell
winget install Neovim.Neovim
winget install Git.Git
winget install BurntSushi.ripgrep.MSVC   # fuzzy text search (telescope)
winget install zig.zig                    # C compiler for treesitter parsers
winget install OpenJS.NodeJS              # required for the JS/TS tools below
```

**macOS (brew):**
```bash
brew install neovim git ripgrep zig node
```

**Linux (apt/your pkg mgr):**
```bash
sudo apt install neovim git ripgrep nodejs npm
# install zig from https://ziglang.org (or your package manager)
```

### 2. Install the language server + formatter (all platforms)
```bash
npm install -g typescript typescript-language-server prettier
```

### 3. Clone this repo to the Neovim config location
- **Windows:** `%LOCALAPPDATA%\nvim`  → `C:\Users\<you>\AppData\Local\nvim`
- **macOS / Linux:** `~/.config/nvim`

```bash
# Windows (PowerShell)
git clone <REPO_URL> "$env:LOCALAPPDATA\nvim"

# macOS / Linux
git clone <REPO_URL> ~/.config/nvim
```

### 4. Launch Neovim
```bash
nvim
```
lazy.nvim auto-installs all plugins on first launch. Then run `:TSUpdate` once to
compile the treesitter parsers (needs zig/cc on PATH).

## Updating the config
After changing `init.lua` or updating plugins (`:Lazy update`), commit and push:
```bash
git add -A
git commit -m "update config"
git push
```
Then `git pull` on your other devices.

## Keeping plugin versions in sync
- `lazy-lock.json` pins exact plugin commits — **commit it** after `:Lazy update`.
- On another device, `:Lazy restore` installs the exact versions from `lazy-lock.json`.
