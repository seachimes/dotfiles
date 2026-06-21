return {
  "gbprod/yanky.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    { "p",     "<Plug>(YankyPutAfter)",      mode = { "n", "x" } },
    { "P",     "<Plug>(YankyPutBefore)",     mode = { "n", "x" } },
    { "gp",    "<Plug>(YankyGPutAfter)",     mode = { "n", "x" } },
    { "gP",    "<Plug>(YankyGPutBefore)",    mode = { "n", "x" } },
    { "<c-n>", "<Plug>(YankyCycleForward)",  mode = { "n" } },
    { "<c-p>", "<Plug>(YankyCycleBackward)", mode = { "n" } },
  }
}
