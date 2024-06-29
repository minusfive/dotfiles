-- configure file tree
return {
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
}
