return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/.config/harper/dictionaries/user.txt",
              fileDictPath = "~/.config/harper/dictionaries/files/",

              codeActions = {
                forceStable = true,
              },
            },
          },
        },
      },
    },
  },
}
