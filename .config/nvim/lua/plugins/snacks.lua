local Logos = require("config.logos")

--- Add the startup section
---@return snacks.dashboard.Section
local function dashboardStartup()
  local stats = Snacks.dashboard.lazy_stats
  stats = stats and stats.startuptime > 0 and stats or require("lazy.stats").stats()
  local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

  return {
    align = "center",
    padding = { 0, 1 },
    text = {
      { stats.loaded .. "/" .. stats.count, hl = "special" },
      { " plugins loaded in ", hl = "footer" },
      { ms .. "ms", hl = "special" },
    },
  }
end

local function pickFilesWithHidden()
  Snacks.picker.smart({ hidden = true })
end

local function pickProjects()
  Snacks.picker.projects()
end

-- local

---@type snacks.picker.layout.Config
local pickerLayoutLg = {
  -- reverse = true,
  preview = true,
  layout = {
    box = "horizontal",
    row = -1,
    width = 0,
    height = 0.4,
    min_height = 20,
    border = "none",
    {
      box = "vertical",
      { win = "input", height = 1, border = "vpad", title = "{source} {live} {flags}", title_pos = "center" },
      { win = "list", border = "none" },
    },
    {
      width = 0.5,
      border = { " ", " ", "", "", "", "", "", "│" },
      title = "{preview}",
      title_pos = "center",
      win = "preview",
    },
  },
}

---@type snacks.picker.layout.Config
local pickerLayoutSm = vim.deepcopy(pickerLayoutLg)
pickerLayoutSm.preview = false

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
          preset = function()
            return vim.o.columns >= 120 and "pickerLayoutLg" or "pickerLayoutSm"
          end,
        },
        layouts = {
          pickerLayoutLg = pickerLayoutLg,
          pickerLayoutSm = pickerLayoutSm,
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
        pickFilesWithHidden,
        desc = "Find Files (Root Dir)",
      },
    },
  },

  {
    "folke/snacks.nvim",
    ---@param opts snacks.Config
    opts = function(_, opts)
      opts.dashboard.preset.keys[1].action = pickFilesWithHidden
      opts.dashboard.preset.keys[3].action = pickProjects
    end,
  },
}
