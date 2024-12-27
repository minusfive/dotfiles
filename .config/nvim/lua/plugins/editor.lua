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
    opts = function(_, opts)
      local fzf_utils = require("fzf-lua.utils")
      local fzf_highlights = require("fzf-lua.config").defaults.__HLS

      LazyVim.merge(opts, {
        winopts = {
          -- border = "none",
          height = 0.5,
          width = 1,
          row = 1,
          col = 0,
        },
        keymap = {
          builtin = {
            true,
            ["<C-h>"] = "toggle-help",
            ["<C-/>"] = "toggle-help",
          },
        },
        defaults = {
          RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
          header = string.format(
            "%s%s%s%s%s%s%s\n\n",
            fzf_utils.ansi_from_hl(fzf_highlights.header_bind, "<C-h>"),
            fzf_utils.ansi_from_hl(fzf_highlights.header_text, ", "),
            fzf_utils.ansi_from_hl(fzf_highlights.header_bind, "<C-/>"),
            fzf_utils.ansi_from_hl(fzf_highlights.header_text, " or "),
            fzf_utils.ansi_from_hl(fzf_highlights.header_bind, "<F1>"),
            fzf_utils.ansi_from_hl(fzf_highlights.header_text, " for "),
            fzf_utils.ansi_from_hl(fzf_highlights.header_bind, "help")
          ),
        },
        grep = {
          rg_glob = true,
        },
      })
    end,
    keys = {
      { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    },
  },
}
