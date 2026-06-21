return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
  },
  config = function()
    -- diagnostics: clean buffer (no inline virtual_text); default sign-column
    -- markers, severity-sorted. View the full diagnostic on demand with
    -- <leader>ge (open_float). Float borders come from the global 'winborder'.
    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
    })

    -- LSP keymaps on attach. nvim 0.11+ already provides grn/gra/grr/gri/K etc.,
    -- and snacks.nvim maps gd/gD/gr/gI/gy to its pickers, so only the custom
    -- bindings are defined here.
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = ev.buf, silent = true, desc = desc })
        end
        map("gn", vim.lsp.buf.rename, "Rename")
        map("ga", vim.lsp.buf.code_action, "Code action")
        map("ge", vim.diagnostic.open_float, "Line diagnostics")
        map("g]", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")
        map("g[", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
      end,
    })

    -- Shared config for every server (nvim 0.11+ native LSP API).
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- mason-lspconfig v2 auto-enables installed servers via vim.lsp.enable.
    require("mason-lspconfig").setup({
      ensure_installed = {
        "vtsls",
        "biome",
        "typos_lsp",
        "lua_ls",
        "emmet_language_server",
        "rust_analyzer",
        "gopls",
        "oxlint",
      },
    })
  end,
}
