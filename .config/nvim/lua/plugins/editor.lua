--- Keymap Group: Lazy
local kmg_lazy = "<leader><c-l>"

return {
  -- Text manipulation
  -- TODO: give this a proper test, or remove
  {
    "tpope/vim-abolish",
    enabled = false,
    event = "VeryLazy",
  },

  -- Git markers on sign column
  {
    "lewis6991/gitsigns.nvim",

    ---@module "gitsigns"
    ---@type Gitsigns.Config | {}
    opts = {
      numhl = false,
      linehl = false,
      culhl = true,
    },
  },

  -- Keybindings help menu
  {
    "folke/which-key.nvim",
    dev = true,
    optional = true,

    ---@module "which-key"
    ---@type wk.Config | {}
    opts = {
      preset = "helix",
      spec = {
        { kmg_lazy, group = "Lazy" },
        { "<leader>l", group = "LSP", icon = { icon = " ", color = "cyan" } },
      },
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      icons = {
        group = "",
      },
    },
    keys = {
      {
        kmg_lazy .. "c",
        function() LazyVim.news.changelog() end,
        desc = "LazyVim Changelog",
      },
      { kmg_lazy .. "d", "<cmd>:LazyDev<cr>", desc = "LazyDev" },
      { kmg_lazy .. "e", "<cmd>:LazyExtras<cr>", desc = "Lazy Extras" },
      { kmg_lazy .. "h", "<cmd>:LazyHealth<cr>", desc = "LazyHealth" },
      { kmg_lazy .. "l", "<cmd>:Lazy<cr>", desc = "Lazy" },
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
}
