-- Notifications, command pop-ups, etc.
local nui_options = {
  popup = {
    win_options = {
      winblend = 5,
    },
  },
}

return {
  "folke/noice.nvim",
  optional = true,
  opts = {
    cmdline = {
      view = "cmdline",
      format = {
        calculator = { icon = "   " },
        cmdline = { icon = "   " },
        filter = { icon = "   " },
        help = { icon = "    " },
        help_vert = { kind = "Help", pattern = "^:%s*verti?c?a?l? he?l?p?%s+", icon = "    " },
        inc_rename = { kind = "IncRename", pattern = "^:IncRename", icon = " 󰑕  " },
        lua = { icon = "   " },
        search_down = { icon = " 󰶹   " },
        search_up = { icon = " 󰶼   " },
      },
    },

    presets = {
      bottom_search = true,
      command_palette = false,
      inc_rename = false,
      long_message_to_split = true,
      lsp_doc_border = true,
    },

    views = {
      cmdline_popupmenu = nui_options.popup,
      confirm = nui_options.popup,
      hover = nui_options.popup,
      popup = nui_options.popup,
      popupmenu = nui_options.popup,
    },
  },
}
