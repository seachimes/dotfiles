return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  -- Defaults are good; only the meaningful overrides are kept here.
  opts = {
    handle = { highlight = "CursorColumn" },
    excluded_filetypes = {
      "noice", "prompt", "snacks_picker_list",
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true, -- integrate with gitsigns marks
      handle = true,
      search = false,  -- requires hlslens
    },
  },
}
