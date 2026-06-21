-- nvim-treesitter `main` branch (required for Neovim 0.11+/0.12; the legacy
-- `master` branch is incompatible with 0.12's treesitter API).
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local langs = {
      "lua", "vim", "vimdoc", "query", "bash",
      "markdown", "markdown_inline",
      "typescript", "javascript", "tsx", "json",
      "html", "css", "yaml", "toml",
      "go", "rust", "python",
    }
    require("nvim-treesitter").install(langs)

    -- start highlighting + treesitter indent only when a parser is available;
    -- pcall so special buffers (e.g. snacks pickers) without a parser don't error
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
