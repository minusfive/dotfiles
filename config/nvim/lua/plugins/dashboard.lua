local logo = string.rep("\n", 8) .. require("config.logos").v

return {
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
}
