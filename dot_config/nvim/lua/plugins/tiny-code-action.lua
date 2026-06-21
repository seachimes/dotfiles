return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  keys = {
    {
      "<leader>ca",
      function()
        require("tiny-code-action").code_action()
      end,
      desc = "tiny-code-action",
    },
  },
  event = "LspAttach",
  opts = {
    picker = "snacks", -- use snacks instead of telescope
  },
}
