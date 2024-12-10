---@type Logos
local Logos = require("config.logos")

-- Notifications, command pop-ups, etc.
local nui_options = {
  popup = {
    win_options = {
      winblend = 5,
    },
  },
}

--- Add the startup section
---@return snacks.dashboard.Section
local function dashboardStartup()
  local D = Snacks.dashboard
  D.lazy_stats = D.lazy_stats and D.lazy_stats.startuptime > 0 and D.lazy_stats or require("lazy.stats").stats()
  local ms = (math.floor(D.lazy_stats.startuptime * 100 + 0.5) / 100)
  return {
    align = "center",
    padding = { 0, 1 },
    text = {
      { D.lazy_stats.loaded .. "/" .. D.lazy_stats.count, hl = "special" },
      { " plugins loaded in ", hl = "footer" },
      { ms .. "ms", hl = "special" },
    },
  }
end

return {
  -- Dashboard
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        preset = {
          header = Logos.v2,
        },
        sections = {
          { section = "header", padding = 0 },
          { title = "Shortcuts", padding = 1, align = "center" },
          { section = "keys", padding = { 1, 0 } },
          { title = "Recent Files", padding = 1, align = "center" },
          { section = "recent_files", padding = 1 },
          { title = "Projects", padding = 1, align = "center" },
          { section = "projects", padding = 1 },
          dashboardStartup,
        },
      },
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
    dependencies = {
      "folke/twilight.nvim",
      opts = function(_, opts)
        opts.context = 5

        Snacks.toggle({
          name = "Twilight",
          get = function()
            return require("twilight.view").enabled
          end,
          set = function()
            require("twilight").toggle()
          end,
        }):map("<leader>ut")
      end,
    },
    opts = function(_, opts)
      opts.window = opts.window or {}
      opts.window.backdrop = 1

      opts.plugins = opts.plugins or {}

      opts.plugins.options = opts.plugins.options or {}
      opts.plugins.options.laststatus = 0

      opts.plugins.twilight = opts.plugins.twilight or {}
      opts.plugins.twilight.enabled = false

      opts.plugins.wezterm = opts.plugins.wezterm or {}
      opts.plugins.wezterm.enabled = true
      opts.plugins.wezterm.font = "+2"

      Snacks.toggle({
        name = "Zen Mode",
        get = function()
          return require("zen-mode.view").is_open()
        end,
        set = function()
          require("zen-mode").toggle()
        end,
      }):map("<leader>uz")
    end,
  },

  -- Animation enhancements
  {
    "sphamba/smear-cursor.nvim",
    optional = true,
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.5,
      distance_stop_animating = 0.3,
      legacy_computing_symbols_support = true,
    },
  },

  {
    "echasnovski/mini.animate",
    optional = true,
    opts = {
      cursor = { enable = false },
      scroll = {
        timing = require("mini.animate").gen_timing.quadratic({
          duration = 50,
          easing = "in-out",
          unit = "total",
        }),
      },
    },
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
    enabled = false,
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
        { "<leader>*", group = "Cloak", icon = LazyVim.config.icons.misc.dots },
        { "<leader>*l", "<cmd>CloakPreviewLine<cr>", desc = "Uncloak Line" },
      })

      Snacks.toggle({
        name = "Cloak",
        get = function()
          return vim.b.cloak_enabled ~= false
        end,
        set = function()
          require("cloak").toggle()
        end,
      }):map("<leader>**")
    end,
  },
}
