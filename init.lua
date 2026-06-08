-- ============================================================================
--  Neovim configuration
--  Theme: Catppuccin Mocha  |  Plugin manager: lazy.nvim
--  Edit this file freely — it's all in one place and commented.
-- ============================================================================

-- ----------------------------------------------------------------------------
--  Leader key  (must be set BEFORE plugins load)
-- ----------------------------------------------------------------------------
vim.g.mapleader = " "        -- Space is the <leader> key
vim.g.maplocalleader = " "

-- ----------------------------------------------------------------------------
--  General options
-- ----------------------------------------------------------------------------
local opt = vim.opt

opt.number = true            -- show line numbers
opt.relativenumber = true    -- relative numbers (great for motions like 5j)
opt.mouse = "a"              -- enable mouse in all modes
opt.showmode = false         -- don't show -- INSERT -- (lualine shows it)

-- Indentation: 4 spaces, no tabs
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
opt.autoindent = true

opt.wrap = false             -- don't wrap long lines
opt.cursorline = true        -- highlight the current line
opt.scrolloff = 8            -- keep 8 lines visible above/below cursor
opt.sidescrolloff = 8
opt.signcolumn = "yes"       -- always show sign column (no text shift)

-- Search
opt.ignorecase = true        -- case-insensitive search...
opt.smartcase = true         -- ...unless you type a capital letter
opt.hlsearch = true          -- highlight matches
opt.incsearch = true         -- show matches as you type

-- Splits open in a natural direction
opt.splitright = true
opt.splitbelow = true

-- Colors & UI
opt.termguicolors = true     -- 24-bit color (required for themes)
opt.background = "dark"

-- Files / persistence
opt.swapfile = false
opt.backup = false
opt.undofile = true          -- persistent undo across sessions
opt.updatetime = 250         -- faster completion / git signs
opt.timeoutlen = 400         -- time to wait for a mapped sequence

-- Share clipboard with the OS
opt.clipboard = "unnamedplus"

-- Nicer completion menu behavior
opt.completeopt = { "menuone", "noselect" }

-- ----------------------------------------------------------------------------
--  Core keymaps  (plugin-specific maps live next to their plugins below)
-- ----------------------------------------------------------------------------
local map = vim.keymap.set

-- Clear search highlight with Esc
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Quick save / quit
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>",  { desc = "Quit window" })

-- Move between windows with Ctrl + h/j/k/l
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Resize windows with arrows
map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Taller" })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Shorter" })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Narrower" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Wider" })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when jumping / searching
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Stay in indent mode after shifting in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ----------------------------------------------------------------------------
--  Bootstrap lazy.nvim (the plugin manager) — auto-installs on first launch
-- ----------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------------------------------------------
--  Plugins
-- ----------------------------------------------------------------------------
require("lazy").setup({

  -- === Theme: Catppuccin Mocha ============================================
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,         -- load before everything else
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",   -- latte | frappe | macchiato | mocha
        transparent_background = false,
        integrations = {
          treesitter = true,
          telescope = true,
          gitsigns = true,
          nvimtree = true,
          which_key = true,
          indent_blankline = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- === Status line ========================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          globalstatus = true,           -- single status line for all windows
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
      })
    end,
  },

  -- === File explorer (toggle with <leader>e) =============================
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 32 },
        renderer = { group_empty = true },
        filters = { dotfiles = false },
      })
      map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- === Fuzzy finder (Telescope) ==========================================
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      local t = require("telescope.builtin")
      map("n", "<leader>ff", t.find_files,  { desc = "Find files" })
      map("n", "<leader>fg", t.live_grep,   { desc = "Grep in project" })
      map("n", "<leader>fb", t.buffers,     { desc = "Open buffers" })
      map("n", "<leader>fh", t.help_tags,   { desc = "Help tags" })
      map("n", "<leader>fr", t.oldfiles,    { desc = "Recent files" })
    end,
  },

  -- === Syntax highlighting (Treesitter) ==================================
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",       -- stable API (ensure_installed, highlight, etc.)
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.install").compilers = { "zig", "clang", "gcc", "cc" }
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "bash", "python", "javascript",
          "typescript", "json", "yaml", "toml", "markdown", "html", "css",
        },
        auto_install = true,                 -- install parsers for new filetypes
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- === Git change indicators in the sign column ==========================
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- === Indentation guides =================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  -- === Auto-close brackets/quotes ========================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- === Popup that shows available keybindings as you type ================
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- === LSP: real "go to definition", references, hover, diagnostics =======
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",            -- :Mason UI to add more servers later
      "hrsh7th/cmp-nvim-lsp",               -- completion capabilities
    },
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })

      -- Tell servers we support the richer completion from nvim-cmp
      local caps = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = caps })

      -- Enable language servers (their executable must be on PATH).
      -- ts_ls = TypeScript/JavaScript (installed globally via npm).
      vim.lsp.enable("ts_ls")

      -- These keymaps activate only in buffers where a language server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local function nmap(lhs, rhs, desc)
            map("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          nmap("gd", vim.lsp.buf.definition,     "Go to definition")
          nmap("gD", vim.lsp.buf.declaration,    "Go to declaration")
          nmap("gr", vim.lsp.buf.references,     "Find references")
          nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
          nmap("K",  vim.lsp.buf.hover,          "Hover documentation")
          nmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
          nmap("[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Previous diagnostic")
          nmap("]d", function() vim.diagnostic.jump({ count =  1, float = true }) end, "Next diagnostic")
          nmap("<leader>d", vim.diagnostic.open_float, "Show diagnostic")
        end,
      })
    end,
  },

  -- === Formatting (Prettier via conform.nvim) ============================
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        -- Which formatter to run for each filetype
        formatters_by_ft = {
          javascript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescript      = { "prettier" },
          typescriptreact = { "prettier" },
          json            = { "prettier" },
          jsonc           = { "prettier" },
          css             = { "prettier" },
          scss            = { "prettier" },
          html            = { "prettier" },
          yaml            = { "prettier" },
          markdown        = { "prettier" },
        },
        -- Auto-format every time you save. To DISABLE, delete this block.
        format_on_save = {
          timeout_ms = 3000,
          lsp_format = "fallback",   -- use the LSP formatter if no prettier
        },
      })

      -- Manual format: <leader>cf  (works even with format-on-save off)
      map({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end, { desc = "Format file/selection" })
    end,
  },

  -- === Autocompletion (pops up as you type) ==============================
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),       -- trigger menu
          ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- accept
          ["<Tab>"]     = cmp.mapping.select_next_item(),
          ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
          ["<C-e>"]     = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

}, {
  -- lazy.nvim UI options
  ui = { border = "rounded" },
  checker = { enabled = false },  -- don't auto-check for plugin updates
})
