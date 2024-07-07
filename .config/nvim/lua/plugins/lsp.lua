return {
  {
    "neovim/nvim-lspconfig",
    --@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "folke/neoconf.nvim",
    opts = {
      import = {
        vscode = false,
      },
    },
  },
}
