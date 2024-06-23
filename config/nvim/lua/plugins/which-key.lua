-- keybindings
return {
  "folke/which-key.nvim",
  optional = true,
  event = "VeryLazy",
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
  },
}
