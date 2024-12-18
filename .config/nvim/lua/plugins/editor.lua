return {
  -- Text manipulation
  {
    "tpope/vim-abolish",
    enabled = false,
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
      window = {
        position = "right",
      },
    },
  },

  -- Fuzzy Finder
  {
    "ibhagwan/fzf-lua",
    optional = true,
    opts = {
      winopts = {
        border = "none",
        height = 0.5,
        width = 1,
        row = 1,
        col = 0,
      },
      grep = {
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
        rg_glob = true,
      },
    },
  },
}
