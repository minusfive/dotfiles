return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },

  {
    "catppuccin/nvim",
    name = "catppuccin",

    ---@module 'catppuccin'
    ---@type CatppuccinOptions
    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = true,
      },

      highlight_overrides = {
        all = function(colors)
          local search_hl = { bg = colors.peach, fg = colors.mantle }
          return {
            -- Flash / search matching Noice colors
            Search = search_hl,
            IncSearch = { link = "Search" },
            CurSearch = { bg = colors.rosewater, fg = colors.base, style = { "bold" } },
            SearchCount = { fg = colors.peach },
            FlashMatch = { link = "Search" },
            FlashLabel = { link = "CurSearch" },

            -- Custom cursor colors per mode
            MCursorInsert = { bg = colors.green, fg = colors.mantle },
            MCursorNormal = { bg = colors.text, fg = colors.mantle },
            MCursorVisual = { bg = colors.text, fg = colors.mauve },
            MCursorReplace = { bg = colors.red, fg = colors.mantle },
            MCursorCommand = { link = "Search" },

            -- Dashboard
            SnacksDashboardDesc = { fg = colors.text },
            SnacksDashboardFile = { fg = colors.text },
            SnacksDashboardFooter = { fg = colors.surface2 },
            SnacksDashboardHeader = { fg = colors.sky },
            SnacksDashboardIcon = { fg = colors.teal },
            SnacksDashboardKey = { fg = colors.teal, style = { "bold" } },
            SnacksDashboardSpecial = { fg = colors.overlay1 },
            SnacksDashboardTitle = { fg = colors.surface1, style = { "underline" } },

            -- Picker
            SnacksPicker = { link = "FloatNormal" },
            SnacksPickerBorder = { fg = colors.crust },
            SnacksPickerTitle = { link = "Search" },
            SnacksPickerListCursorLine = { bg = colors.mantle },
            SnacksPickerListItemSign = { fg = colors.base },
            SnacksPickerListItemSignCursorLine = { bg = colors.mantle, fg = colors.peach },
            SnacksPickerMatch = { bg = nil, fg = nil, style = { "underline" } },
            SnacksPickerPreviewCursorLine = { link = "SnacksPickerCursorLine" },
            SnacksPickerPreviewTitle = { bg = colors.sapphire, fg = colors.base },
            SnacksPickerPrompt = { link = "Command" },
            SnacksPickerFlag = vim.tbl_extend("force", {}, search_hl, { style = { "italic" } }),

            -- Make some elements more subtle
            SnacksIndent = { fg = colors.surface0 },
            SnacksIndentScope = { fg = colors.surface2 },
            SnacksIndentChunk = { fg = colors.surface2 },

            -- Command utils themed with command mode colors (orange-ish)
            Command = { fg = colors.peach },
            NoiceCmdlineIcon = search_hl,
            NoiceCmdlineIconSearch = search_hl,
            NoiceCmdlinePopupBorder = { fg = colors.peach },
            NoiceCmdlinePopupTitle = { fg = colors.peach },

            -- Visual selections with inverted colors matching lualine mode bg
            Visual = { bg = colors.mauve, fg = colors.mantle, style = { "bold" } },
            VisualNOS = { link = "Visual" },

            -- Floating Windows
            FloatNormal = { bg = colors.base },
            FloatBorder = { fg = colors.surface1, bg = colors.base },

            -- Fuzzy Finder
            FzfLuaBorder = { fg = colors.surface1, bg = colors.base },
            FzfLuaNormal = { bg = colors.base },
            FzfLuaTitle = { fg = colors.crust, bg = colors.peach, style = { "bold" } },
            FzfLuaPreviewTitle = { fg = colors.crust, bg = colors.blue, style = { "bold" } },
            FzfLuaHeaderText = { fg = colors.overlay1 },
            FzfLuaHeaderBind = { fg = colors.subtext1 },
            FzfLuaFzfPrompt = { fg = colors.peach },
            FzfLuaFzfPointer = { fg = colors.peach },
            FzfLuaFzfHeader = { fg = colors.overlay0 },

            -- Cursorline
            CursorLine = { bg = colors.mantle },
            CursorLineNr = { link = "CursorLine", fg = colors.text, style = { "bold" } },
            CursorLineSign = { link = "CursorLine" },
            GitSignsAddCul = { bg = colors.mantle, fg = colors.green },
            GitSignsChangeCul = { bg = colors.mantle, fg = colors.yellow },
            GitSignsDeleteCul = { bg = colors.mantle, fg = colors.red },

            -- Completon
            BlinkCmpItemIdx = { fg = colors.surface2 },
            BlinkCmpMenuSelection = { bg = colors.surface1, style = { "bold" } },
            BlinkCmpDoc = { bg = colors.surface0 },
          }
        end,
      },

      integrations = {
        dap = true,
        dap_ui = true,
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
