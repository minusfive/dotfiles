-- status line
return {
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

    opts.options.disabled_filetypes.winbar = vim.deepcopy(opts.options.disabled_filetypes.statusline)
    table.insert(opts.options.disabled_filetypes.winbar, "neo-tree")

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
}
