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
    keys = {
      { "<leader>hs", "<cmd>CloakToggle<cr>", desc = "Secrets (Toggle)" },
    },
    opts = { enabled = true },
  },
}
