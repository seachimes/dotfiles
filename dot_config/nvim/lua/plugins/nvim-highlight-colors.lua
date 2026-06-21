return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = 'virtual', -- or 'foreground' or 'first_column'
      enable_named_colors = true,
      enable_tailwind = true,
    },
  }
}
