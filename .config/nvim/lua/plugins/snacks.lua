local Logos = require("config.logos")

-- Borders
local border = {
  topPad = { "", " ", "", "", "", "", "", "" },
}

-- Window options
local wo = {
  snacks = {
    picker = {
      list = {
        statuscolumn = "%#SnacksPickerListItemSign#%{v:relnum?'▎':''}%#SnacksPickerListItemSignCursorLine#%{v:relnum?'':'▎'}",
        number = true,
        numberwidth = 1,
        relativenumber = true,
      },
      preview = {
        foldcolumn = "0",
        number = true,
        relativenumber = false,
        signcolumn = "no",
      },
    },
  },
}

local function responsiveLayout() return vim.o.columns >= 120 and "lg" or "sm" end

return {
  {
    "folke/snacks.nvim",
    -- dev = true,

    ---@type snacks.Config.base
    opts = {
      -- Animation
      animate = {
        easing = "inQuad",
        duration = { total = 100 },
      },

      -- Dashboard
      dashboard = {
        width = 50,

        preset = {
          header = Logos.v2,
          keys = {
            { icon = " ", key = "s", desc = "Session Restore", section = "session" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = "<leader><space>" },
            { icon = " ", key = "g", desc = "Find Text (grep)", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },

        sections = {
          { section = "header", padding = { 0, 0 } },
          { title = "", padding = { 1, 0 }, align = "center" },
          { section = "keys", padding = { 0, 0 } },
          { title = "", padding = { 1, 0 }, align = "center" },

          --- Stats
          function()
            local stats = Snacks.dashboard.lazy_stats
            stats = stats and stats.startuptime > 0 and stats or require("lazy.stats").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

            return {
              align = "center",
              padding = { 0, 0 },
              text = {
                { tostring(stats.loaded), hl = "special" },
                { " out of ", hl = "footer" },
                { tostring(stats.count), hl = "special" },
                { " plugins loaded in ", hl = "footer" },
                { ms .. "ms", hl = "special" },
              },
            }
          end,
        },
      },

      -- Indentation guides
      indent = {
        indent = {
          only_current = true,
          only_scope = true,
        },
        scope = {
          only_current = true,
          animate = {
            easing = "inQuad",
            duration = { total = 100 },
          },
        },
      },

      -- Picker
      picker = {
        layout = {
          cycle = true,
          preset = responsiveLayout,
        },

        icons = {
          ui = {
            hidden = "󰘓 ",
            ignored = "󰷊 ",
            follow = " ",
          },
        },

        layouts = {
          lg = {
            preview = true,
            layout = {
              box = "horizontal",
              row = -1,
              width = 0,
              height = 0.51,
              min_height = 20,
              {
                box = "vertical",
                border = "right",
                {
                  win = "input",
                  height = 1,
                  border = border.topPad,
                  title = "{source} {live} {flags}",
                  title_pos = "center",
                },
                {
                  win = "list",
                  border = "top",
                  wo = wo.snacks.picker.list,
                },
              },
              {
                win = "preview",
                title = "{preview}",
                title_pos = "center",
                width = 0.56,
                border = "vpad",
                minimal = true,
                wo = wo.snacks.picker.preview,
              },
            },
          },

          sm = {
            preview = true,
            fullscreen = true,
            layout = {
              box = "vertical",
              border = "none",
              {
                win = "preview",
                title = "{preview}",
                title_pos = "center",
                height = 0.5,
                border = "top",
                minimal = true,
                wo = wo.snacks.picker.preview,
              },
              {
                box = "vertical",
                { win = "input", height = 1, border = "top", title = "{source} {live} {flags}", title_pos = "center" },
                {
                  win = "list",
                  border = "top",
                  wo = wo.snacks.picker.list,
                },
              },
            },
          },
        },

        formatters = {
          file = {
            filename_first = true,
          },
        },

        sources = {
          explorer = {
            hidden = true,
            layout = {
              preset = responsiveLayout,
              preview = true,
            },
          },
          files = {
            hidden = true,
          },
          grep = {
            hidden = true,
          },
        },
      },

      -- Scroll Animation
      scroll = {
        animate = {
          duration = { total = 100 },
        },
      },

      -- Status Column
      statuscolumn = {
        left = { "sign", "git" },
        right = { "mark", "fold" },
      },
    },

    keys = {
      {
        "<leader><space>",
        function() Snacks.picker.smart({ hidden = true }) end,
        desc = "Find Files (Root Dir)",
      },
    },
  },
}
