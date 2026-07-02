-- leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- window splits (move between panes with herdr's prefix+h/j/k/l; inside nvim
-- use the built-in C-w h/j/k/l)
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<cr>", { silent = true, desc = "Split vertical" })
vim.keymap.set("n", "<leader>hs", "<cmd>split<cr>", { silent = true, desc = "Split horizontal" })
