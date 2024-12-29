return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     ---@module 'lspconfig'
  --     ---@type {[string]: lspconfig.Config|{}}
  --     servers = {
  --       bashls = {
  --         filetypes = { "bash", "sh", "zsh" },
  --       },
  --     },
  --   },
  -- },
  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      lang_to_ft = {
        zsh = "sh",
      },
      formatters_by_ft = {
        zsh = { "shfmt" },
      },
    },
  },
}
