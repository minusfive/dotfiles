return {
  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>h"] = { name = "+hide" },
      },
    },
  },
  {
    "laytan/cloak.nvim",
    keys = {
      { "<leader>hs", "<cmd>CloakToggle<cr>", desc = "Secrets (Toggle)" },
    },
    opts = { enabled = true },
  },
}
