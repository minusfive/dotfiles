---@type Logos
local Logos = require("config.logos")

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

---@param opts snacks.toggle.Config?
local function zen_toggle(opts)
  ---@type snacks.win?
  local zen_win = nil

  return Snacks.toggle({
    id = "zen",
    name = "Zen Mode",
    get = function()
      return zen_win and zen_win:valid() or false
    end,
    set = function()
      zen_win = Snacks.zen()
    end,
  }, opts)
end

return {
  {
    "folke/snacks.nvim",

    ---@param opts snacks.Config
    opts = function(_, opts)
      ---@type snacks.Config
      local snacksConfig = {

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

        -- Focus mode
        zen = {
          enabled = true,
        },
      }

      LazyVim.merge(opts, snacksConfig)

      require("which-key").add({
        { "<leader>uz", group = "Zen Mode" },
      })

      zen_toggle():map("<leader>uzm")
      Snacks.toggle.dim():map("<leader>uzd")
    end,
  },
}
