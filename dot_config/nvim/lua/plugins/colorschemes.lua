return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        treesitter = true,
        snacks = true,
        noice = true,
        which_key = true,
        mason = true,
        native_lsp = { enabled = true },
      },
    },
  },
}
