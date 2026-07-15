return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Window/pane left" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Window/pane down" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Window/pane up" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Window/pane right" },
  },
}
