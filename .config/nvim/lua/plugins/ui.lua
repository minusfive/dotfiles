local logo = string.rep("\n", 8) .. require("config.logos").v

-- Notifications, command pop-ups, etc.
local nui_options = {
  popup = {
    win_options = {
      winblend = 5,
    },
  },
}

return {
  -- loading screen
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- opts.theme = "hyper"
      opts.config.header = vim.split(logo, "\n")
      opts.config.center[1].action = "Telescope file_browser"
      opts.config.footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return { "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
      end
      return opts
    end,
  },

  -- Notification messages
  {
    "rcarriga/nvim-notify",
    optional = true,
    opts = {
      fps = 120,
      stages = "slide",
      render = "wrapped-compact",
      top_down = false,
    },
  },

  -- Window enhancements
  {
    "folke/edgy.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      animate = {
        fps = 120,
        cps = 360,
      },
      left = {
        {
          ft = "neo-tree",
          size = { width = 50 },
        },
      },
    },
  },

  -- Notification messages
  {
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
  },

  -- Focus mode
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    dependencies = { "folke/twilight.nvim", opts = { context = 15 } },
    opts = {
      backdrop = 0,
      optionns = {
        laststatus = 0,
      },
      plugins = {
        twilight = { enabled = false },
        wezterm = { enabled = true, font = "+2" },
      },
    },
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
  },

  -- Animation enhancements
  {
    "echasnovski/mini.animate",
    enabled = false,
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local animate = require("mini.animate")

      opts.cursor = {
        enable = false,
        timing = animate.gen_timing.quadratic({ duration = 150, unit = "total" }),
      }

      opts.open = { enable = false }
      opts.close = { enable = false }

      opts.scroll.timing = animate.gen_timing.quadratic({ duration = 60, unit = "total" })

      return opts
    end,
  },

  -- Indentation scope line
  {
    "echasnovski/mini.indentscope",
    optional = true,
    opts = function(_, opts)
      opts.draw = opts.draw or {}
      opts.draw.animation = require("mini.indentscope").gen_animation.none()
    end,
  },

  -- Statusline, Winbar and Bufferline (buffer tabs) configuration
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local colors = require("catppuccin.palettes").get_palette("mocha")

      -- local icons = require("lazyvim.config").icons
      local c = opts.sections.lualine_c
      local diagnostics = c[2]
      local file_type_icon = c[3]
      -- local pretty_path = c[4]
      -- local root_dir = c[1]
      local symbols = c[5]

      local x = opts.sections.lualine_x
      local cmd = table.remove(x, 1)
      local diff = table.remove(x)

      cmd.color = "Command"
      file_type_icon.color = file_type_icon.color or {}
      file_type_icon.color.bg = colors.mantle

      opts.options.component_separators = { "", "" }
      opts.options.section_separators = { "", "" }

      opts.sections.lualine_a = {}
      opts.sections.lualine_b = { { "%p%% %c" } }
      opts.sections.lualine_c = { cmd }
      opts.sections.lualine_y = { "branch" }
      opts.sections.lualine_z = {}

      vim.list_extend(opts.options.disabled_filetypes.statusline, { "neo-tree" })
      vim.list_extend(opts.options.disabled_filetypes.statusline, { "edgy" })
      opts.options.disabled_filetypes.winbar = vim.deepcopy(opts.options.disabled_filetypes.statusline)

      opts.winbar = {
        lualine_a = {
          {
            "bo:modified",
            fmt = function(output)
              return output == "true" and "󱇧" or nil
            end,
            color = { bg = colors.yellow },
          },
          {
            "bo:readonly",
            fmt = function(output)
              return output == "true" and "󰈡" or nil
            end,
            color = { bg = colors.red },
          },
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },

        lualine_b = {
          file_type_icon,
          { "filename", file_status = false, path = 1, color = { bg = colors.mantle } },
        },
        lualine_c = { symbols },
        lualine_x = {
          { "searchcount", color = "SearchCount" },
          diagnostics,
          diff,
        },
      }

      opts.inactive_winbar = {
        lualine_c = opts.winbar.lualine_b,
        lualine_x = opts.winbar.lualine_x,
      }
    end,
  },

  -- Bufferline (buffer tabs)
  {
    "akinsho/bufferline.nvim",
    -- optional = true,
    enabled = false,
    -- opts = function(_, opts)
    --   local bufferline = require("bufferline")
    --   opts.options.always_show_bufferline = true
    --   opts.options.buffer_close_icon = "✕"
    --   opts.options.close_icon = opts.options.buffer_close_icon
    --   opts.options.hover = {
    --     enabled = true,
    --     delay = 200,
    --     reveal = { "close", "buffer_close" },
    --   }
    --   opts.options.indicator = {
    --     icon = "",
    --     style = "underline",
    --   }
    --   opts.options.separator_style = { "", "" }
    --   opts.options.show_close_icon = true
    --   opts.options.show_buffer_close_icons = true
    --   opts.options.show_duplicate_prefix = true
    --   opts.options.style_preset = bufferline.style_preset.minimal
    --   opts.options.tab_size = 20
    -- end,
  },

  -- Hide Secrets
  {
    "laytan/cloak.nvim",
    event = "VeryLazy",
    config = true,
    opts = function(_, opts)
      opts.cloak_length = 5
      opts.cloak_on_leave = true

      require("which-key").add({
        { "<leader>u*", group = "Cloak", icon = LazyVim.config.icons.misc.dots },
        { "<leader>u*l", "<cmd>CloakPreviewLine<cr>", desc = "Uncloak Line" },
      })

      Snacks.toggle({
        name = "Cloak",
        get = function()
          return vim.b.cloak_enabled ~= false
        end,
        set = function()
          require("cloak").toggle()
        end,
      }):map("<leader>u**")
    end,
  },
}
