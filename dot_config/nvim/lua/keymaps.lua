-- leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- window splits (C-h/j/k/l navigation is handled by vim-tmux-navigator,
-- which also moves seamlessly between nvim splits and tmux panes)
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<cr>", { silent = true, desc = "Split vertical" })
vim.keymap.set("n", "<leader>hs", "<cmd>split<cr>", { silent = true, desc = "Split horizontal" })
