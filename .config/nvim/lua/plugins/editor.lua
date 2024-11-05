return {
  -- Text manipulation
  {
    "tpope/vim-abolish",
    event = "VeryLazy",
  },
  -- Keybindings help menu
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<leader>n", group = "new", icon = LazyVim.config.icons.git.added },
        { "<leader>u*", group = "cloak", icon = LazyVim.config.icons.misc.dots },
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

  -- File explorer
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
