-- focus mode
return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  dependencies = { "folke/twilight.nvim", opts = { context = 15 } },
  opts = {
    plugins = {
      wezterm = { enabled = true },
    },
  },
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
  },
}
