return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>dv", "<cmd>DiffviewOpen<CR>",  desc = "Open Diffview" },
      { "<leader>dV", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
    },
    opts = {
      -- diff_binaries = false,
      -- enhanced_diff_hl = true,
    },
  },
}
