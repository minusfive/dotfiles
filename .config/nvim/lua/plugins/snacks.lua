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

    ---@param opts snacks.Config
    opts = function(_, opts)
      ---@type snacks.Config
      local snacksConfig = {
        -- Animation
        ---@type snacks.animate.Config
        animate = {
          easing = "inQuad",
        },

        -- Dashboard
        ---@type snacks.dashboard.Config
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
        ---@type snacks.indent.Config
        indent = {
          indent = {
            enabled = true,
            only_scope = false,
            only_current = true,
          },
          scope = {
            enabled = true,
            only_current = true,
            animate = {
              enabled = true,
              duration = { total = 250 },
            },
          },
          chunk = {
            enabled = false,
          },
        },

        -- Animate scroll
        ---@type snacks.scroll.Config
        scroll = {
          enabled = true,
          animate = {
            duration = { total = 100 },
          },
        },

        -- Focus mode
        ---@type snacks.zen.Config
        zen = { enabled = true },
      }

      LazyVim.merge(opts, snacksConfig)

      require("which-key").add({
        { "<leader>uz", group = "Zen Mode" },
      })

      Snacks.toggle.zen():map("<leader>uzz")
      Snacks.toggle.dim():map("<leader>uzd")
    end,
  },
}
