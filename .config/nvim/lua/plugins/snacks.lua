local Logos = require("config.logos")

return {
  {
    "folke/snacks.nvim",
    -- dev = true,

    ---@type snacks.Config
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
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = "<leader><space>" },
            { icon = " ", key = "g", desc = "Find Text (grep)", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", padding = { 0, 0 } },
          { title = "", padding = { 1, 0 }, align = "center" },
          { title = nil, section = "keys", padding = { 0, 0 } },
          { title = "", padding = { 1, 0 }, align = "center" },
          -- Unused
          -- { title = "Recent Files", padding = 1, align = "center" },
          -- { section = "recent_files", padding = 1 },
          -- { title = "Projects", padding = 1, align = "center" },
          -- { section = "projects", padding = 1 },

          --- Stats
          function()
            local stats = Snacks.dashboard.lazy_stats
            stats = stats and stats.startuptime > 0 and stats or require("lazy.stats").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

            return {
              align = "center",
              padding = { 0, 0 },
              text = {
                { stats.loaded .. "/" .. stats.count, hl = "special" },
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
        layout = function()
          return vim.o.columns >= 120 and "lg" or "sm"
        end,

        layouts = {
          lg = {
            preview = true,
            layout = {
              box = "horizontal",
              row = -1,
              width = 0,
              height = 0.4,
              min_height = 20,
              {
                box = "vertical",
                border = "right",
                {
                  win = "input",
                  height = 1,
                  border = { "", " ", "", "", "", "", "", "" },
                  title = "{source} {live} {flags}",
                  title_pos = "center",
                },
                { win = "list", border = "top" },
              },
              {
                win = "preview",
                title = "{preview}",
                title_pos = "center",
                width = 0.5,
                border = "vpad",
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
              },
              {
                box = "vertical",
                { win = "input", height = 1, border = "top", title = "{source} {live} {flags}", title_pos = "center" },
                { win = "list", border = "top" },
              },
            },
          },
        },
        formatters = {
          file = {
            filename_first = true,
          },
        },
        win = {
          list = {
            wo = {
              statuscolumn = "%#SnacksPickerListItemSign#%{v:relnum?'▎':''}%#SnacksPickerListItemSignCursorLine#%{v:relnum?'':'▎'}",
              number = true,
              numberwidth = 1,
              relativenumber = true,
            },
          },
          preview = {
            minimal = true,
            wo = {
              foldcolumn = "0",
              number = true,
              relativenumber = false,
              signcolumn = "no",
            },
          },
        },
        sources = {
          files = {
            hidden = true,
          },
          smart = {
            actions = {
              smart_delete = function(picker, item)
                if item.buf then
                  Snacks.picker.actions.bufdelete(picker, item)
                  return
                end

                Snacks.notify.warn("Not an open buffer", { title = "Smart Picker" })
              end,
            },
            win = {
              input = {
                keys = {
                  ["dd"] = "smart_delete",
                  ["<c-x>"] = { "smart_delete", mode = { "n", "i" } },
                },
              },
              list = { keys = { ["dd"] = "smart_delete" } },
            },
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
        function()
          Snacks.picker.smart()
        end,
        desc = "Find Files (Root Dir)",
      },
    },
  },
}
