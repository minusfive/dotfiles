-- keybindings
return {
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      spec = {
        ["<leader>n"] = { name = "+new" },
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd([[
              setlocal relativenumber
            ]])
          end,
        },
      },
      source_selector = {
        winbar = true,
      },
      window = { width = 42 },
    },
  },
}
