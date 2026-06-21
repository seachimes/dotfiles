require 'format'
require 'status'

local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- default domain (WSL is only valid on Windows; guard keeps the config portable)
if wezterm.target_triple:find('windows') then
  config.default_domain = 'WSL:Ubuntu'

  -- new sessions otherwise open in the Windows user dir (/mnt/c/Users/...).
  -- Start the WSL domain in the Linux $HOME instead. default_cwd needs an
  -- absolute path ('~' is NOT expanded here), so resolve $HOME from WSL rather
  -- than hardcoding the username.
  local wsl_home
  local ok, success, stdout = pcall(wezterm.run_child_process,
    { 'wsl.exe', '-d', 'Ubuntu', 'sh', '-lc', 'printf %s "$HOME"' })
  if ok and success and stdout and stdout ~= '' then
    wsl_home = (stdout:gsub('%s+$', ''))
  end

  local wsl_domains = wezterm.default_wsl_domains()
  for _, dom in ipairs(wsl_domains) do
    if dom.name == 'WSL:Ubuntu' and wsl_home then
      dom.default_cwd = wsl_home
    end
  end
  config.wsl_domains = wsl_domains
end

-- keybinds
local keybinds = require 'keybinds'
config.leader = { key = ',', mods = 'CTRL', timeout_milliseconds = 2000 }
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables
config.disable_default_key_bindings = true

-- colors
-- config.color_scheme = 'nord'
-- config.color_scheme = 'duskfox'
-- config.color_scheme = 'Heetch Light (base16)'
-- config.color_scheme = 'Kasugano (terminal.sexy)'
-- config.color_scheme = 'lovelace'
-- config.color_scheme = 'Palenight (Gogh)'
-- config.color_scheme = 'Rebecca (base16)'
-- config.color_scheme = 'Tokyo Night Moon'
-- config.color_scheme = 'wilmersdorf'
-- config.color_scheme = 'rose-pine'
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'iceberg-dark'

config.window_background_opacity = 0.8

-- font
config.font = wezterm.font("Firge35Nerd Console")
config.font_size = 11.0

-- status
config.status_update_interval = 1000

-- window decorations
config.window_decorations = "RESIZE"
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

return config
