-- Configures lua_ls for Neovim development: makes the `vim` global and the
-- Neovim/plugin Lua API known to the language server (fixes "undefined global
-- vim" and adds completion/types for vim.* and required modules).
return {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      -- types for vim.uv
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- snacks.nvim types + the `Snacks` global (loaded when "Snacks" appears)
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  },
}
