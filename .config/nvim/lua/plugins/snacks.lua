---@type Logos
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

return {
  {
    "folke/snacks.nvim",

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

      -- Scroll Animation
      scroll = {
        -- TODO: Nested animation configs should be partial as well
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
  },
}
