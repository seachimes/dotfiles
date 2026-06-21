-- Project-wide search & replace UI (ripgrep-powered).
return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function() require("grug-far").open() end,
      mode = { "n", "x" },
      desc = "Search & Replace (grug-far)",
    },
  },
  opts = {},
}
