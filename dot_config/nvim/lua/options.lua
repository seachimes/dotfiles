local o = vim.o

-- general
o.termguicolors = true
o.scrolloff = 4
o.ignorecase = true
o.smartcase = true
o.inccommand = 'split'
o.clipboard = 'unnamedplus'
o.list = true
o.undofile = true       -- persistent undo
o.splitright = true
o.splitbelow = true

-- ui
o.number = true
o.cursorline = true
o.signcolumn = 'yes:1'
o.wrap = false
o.winborder = 'rounded'   -- global rounded border for all floating windows (0.11+)

-- indentation (2-space default; override per-language via filetype/editorconfig)
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

-- WSL clipboard via xsel (only under WSL; elsewhere nvim's default provider works)
local uname = (vim.uv or vim.loop).os_uname().release:lower()
if vim.fn.has('wsl') == 1 or uname:find('microsoft') or uname:find('wsl') then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'xsel -bi',
      ['*'] = 'xsel -bi',
    },
    paste = {
      ['+'] = 'xsel -bo',
      ['*'] = function() return vim.fn.systemlist('xsel -bo | tr -d "\r"') end,
    },
    cache_enabled = 1,
  }
end
