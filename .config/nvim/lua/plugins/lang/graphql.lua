return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "graphql")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    --@class PluginLspOpts
    opts = {
      servers = { graphql = {} },
    },
  },
}
