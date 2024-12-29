return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@module 'lspconfig'
      ---@type {[string]: lspconfig.Config|{}}
      servers = {
        nil_ls = { enabled = false },
        nixd = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },
}
