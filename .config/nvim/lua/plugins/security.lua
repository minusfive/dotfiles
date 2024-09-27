return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        ["<leader>h"] = { name = "+hide" },
      },
    },
  },
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>hs", "<cmd>CloakToggle<cr>", desc = "Secrets (Toggle)" },
    },
    config = true,
  },
}
