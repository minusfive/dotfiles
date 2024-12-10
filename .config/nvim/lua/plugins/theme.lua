return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    -- optional = true,
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
      dim_inactive = {
        enabled = true,
      },

      highlight_overrides = {
        all = function(colors)
          local search = { bg = colors.peach, fg = colors.mantle }
          local search_selection = { bg = colors.rosewater, fg = colors.base, style = { "bold" } }
          local visual = { bg = colors.mauve, fg = colors.mantle, style = { "bold" } }

          return {
            -- Custom cursor colors per mode
            MCursorInsert = { bg = colors.green, fg = colors.mantle },
            MCursorNormal = { bg = colors.text, fg = colors.mantle },
            MCursorVisual = { bg = colors.text, fg = colors.mauve },
            MCursorReplace = { bg = colors.red, fg = colors.mantle },
            MCursorCommand = search,

            -- Dashboard
            SnacksDashboardDesc = { fg = colors.text },
            SnacksDashboardFile = { fg = colors.text },
            SnacksDashboardFooter = { fg = colors.surface2 },
            SnacksDashboardHeader = { fg = colors.blue },
            SnacksDashboardIcon = { fg = colors.mauve },
            SnacksDashboardKey = { fg = colors.green },
            SnacksDashboardSpecial = { fg = colors.overlay1 },
            SnacksDashboardTitle = { fg = colors.overlay0, style = { "underline" } },

            -- Make some elements more subtle
            MiniIndentscopeSymbol = { fg = colors.surface2 },

            -- Command utils themed with command mode colors (orange-ish)
            Command = { fg = colors.peach },
            NoiceCmdlineIcon = search,
            NoiceCmdlineIconSearch = search,
            NoiceCmdlinePopupBorder = { fg = colors.peach },
            NoiceCmdlinePopupTitle = { fg = colors.peach },

            -- Flash / search matching Noice colors
            FlashLabel = search_selection,
            FlashMatch = search,
            Search = search,
            IncSearch = search,
            CurSearch = search_selection,
            SearchCount = { fg = colors.peach },

            -- Visual selections with inverted colors matching lualine mode bg
            Visual = visual,
            VisualNOS = visual,

            -- Floating Windows
            FloatBorder = { fg = colors.surface2 },
          }
        end,
      },

      integrations = {
        dap = {
          enabled = true,
          enable_ui = true,
        },
      },
    },
  },

  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    -- optional = true,
    opts = {
      dim_inactive = true,
      lualine_bold = true,
      style = "night",

      styles = {
        sidebars = "dark",
        floats = "dark",
        -- sidebars = "transparent",
        -- floats = "transparent",
      },

      -- transparent = true,
      use_background = "dark",

      on_colors = function(colors)
        colors.border_highlight = colors.dark3
      end,

      on_highlights = function(highlights, colors)
        highlights.CursorLine.bg = colors.bg_dark
        highlights.NoiceCmdlineIcon = highlights.DinosticWarn
        highlights.NoiceCmdlinePopupBorder = highlights.DiagnosticWarn
        highlights.NoiceCmdlinePopupTitle = highlights.DiagnosticWarn
        highlights.DashboardFooter.fg = colors.blue0
        highlights.TreesitterContext.bg = highlights.BufferTabpageFill.bg
      end,
    },
  },

  {
    "nyoom-engineering/oxocarbon.nvim",
    name = "oxocarbon",
    -- optional = true,
    -- Add in any other configuration;
    --   event = foo,
    --   config = bar
    --   end,
  },
}
