local Util = require("lazyvim.util")
local unpack = unpack or table.unpack
local logo = string.rep("\n", 8) .. require("config.logos").v

local commands = {
  telescope = {
    file_browser = "Telescope file_browser",
    undo = "Telescope undo",
  },
}

local nui_options = {
  popup = {
    win_options = {
      winblend = 5,
    },
  },
}

local cmp_window_options = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
}

return {
  -- startup screen
  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- opts.theme = "hyper"
      opts.config.header = vim.split(logo, "\n")
      opts.config.center[1].action = commands.telescope.file_browser
      opts.config.footer = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        return { "Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
      end
      return opts
    end,
  },

  -- colorscheme tweaks
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      lualine_bold = true,
      style = "night",

      styles = {
        sidebars = "dark",
        floats = "dark",
        -- sidebars = "transparent",
        -- floats = "transparent",
      },

      -- transparent = true,
      use_background = "dark",

      on_colors = function(colors)
        colors.border_highlight = colors.dark3
      end,

      on_highlights = function(highlights, colors)
        highlights.CursorLine.bg = colors.bg_dark
        highlights.NoiceCmdlineIcon = highlights.DinosticWarn
        highlights.NoiceCmdlinePopupBorder = highlights.DiagnosticWarn
        highlights.NoiceCmdlinePopupTitle = highlights.DiagnosticWarn
        highlights.DashboardFooter.fg = colors.blue0
        highlights.TreesitterContext.bg = highlights.BufferTabpageFill.bg
      end,
    },
  },

  {
    "catppuccin/nvim",
    optional = true,
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
      dim_inactive = {
        enabled = true,
      },

      highlight_overrides = {
        all = function(colors)
          local search = { bg = colors.peach, fg = colors.mantle }
          local search_selection = { bg = colors.rosewater, fg = colors.base, style = { "bold" } }
          local visual = { bg = colors.mauve, fg = colors.mantle, style = { "bold" } }

          return {
            -- Custom cursor colors per mode
            MCursorInsert = { bg = colors.green, fg = colors.mantle },
            MCursorNormal = { bg = colors.text, fg = colors.mantle },
            MCursorVisual = { bg = colors.text, fg = colors.mauve },
            MCursorReplace = { bg = colors.red, fg = colors.mantle },
            MCursorCommand = search,

            -- Make some elements more subtle
            DashboardFooter = { fg = colors.surface2 },
            MiniIndentscopeSymbol = { fg = colors.surface2 },

            -- Command utils themed with command mode colors (orange-ish)
            Command = { fg = colors.peach },
            NoiceCmdlineIcon = search,
            NoiceCmdlineIconSearch = search,
            NoiceCmdlinePopupBorder = { fg = colors.peach },
            NoiceCmdlinePopupTitle = { fg = colors.peach },

            -- Flash / search matching Noice colors
            FlashLabel = search_selection,
            FlashMatch = search,
            Search = search,
            IncSearch = search,
            CurSearch = search_selection,
            SearchCount = { fg = colors.peach },

            -- Visual selections with inverted colors matching lualine mode bg
            Visual = visual,
            VisualNOS = visual,

            -- Floating Windows
            FloatBorder = { fg = colors.surface2 },
          }
        end,
      },

      integrations = {
        dap = {
          enabled = true,
          enable_ui = true,
        },
      },
    },
  },

  -- Indent line scope highlight
  {
    "echasnovski/mini.indentscope",
    optional = true,
    opts = function(_, opts)
      opts.draw = opts.draw or {}
      opts.draw.animation = require("mini.indentscope").gen_animation.none()
    end,
  },

  -- Notifications, command pop-ups, etc.
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
          lua = { icon = "   " },
          search_down = { icon = " 󰶹   " },
          search_up = { icon = " 󰶼   " },
        },
      },

      presets = {
        command_palette = false,
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

  {
    "rcarriga/nvim-notify",
    optional = true,
    opts = {
      fps = 60,
      stages = "slide",
      render = "wrapped-compact",
      top_down = false,
    },
  },

  -- ui tabs
  {
    "akinsho/bufferline.nvim",
    optional = true,
    enabled = false,
    opts = function(_, opts)
      local bufferline = require("bufferline")
      opts.options.always_show_bufferline = true
      opts.options.buffer_close_icon = "✕"
      opts.options.close_icon = opts.options.buffer_close_icon
      opts.options.hover = {
        enabled = true,
        delay = 200,
        reveal = { "close", "buffer_close" },
      }
      opts.options.indicator = {
        icon = "",
        style = "underline",
      }
      opts.options.separator_style = { "", "" }
      opts.options.show_close_icon = true
      opts.options.show_buffer_close_icons = true
      opts.options.show_duplicate_prefix = true
      opts.options.style_preset = bufferline.style_preset.minimal
      opts.options.tab_size = 20
    end,
  },

  -- status line
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
  },

  -- focus mode
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    dependencies = { "folke/twilight.nvim", opts = { context = 15 } },
    opts = {
      plugins = {
        wezterm = { enabled = true },
      },
    },
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
      { "<leader>zt", "<cmd>Twilight<cr>", desc = "Twilight" },
    },
  },

  -- keybindings
  {
    "folke/which-key.nvim",
    optional = true,
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
    },
  },

  -- configure file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd([[
              setlocal relativenumber
            ]])
          end,
        },
      },
      source_selector = {
        winbar = true,
      },
    },
  },

  -- edgy
  {
    "folke/edgy.nvim",
    optional = true,
    opts = {
      animate = {
        fps = 120,
        cps = 360,
      },
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "kdl")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    optional = true,
    opts = { max_lines = 1, trim_scope = "inner" },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    --@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = false },
      servers = { eslint = {} },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" or client.name == "vtsls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Browse files with telescope
      {
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("file_browser")
          end)
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        event = "VeryLazy",
        config = function()
          Util.on_load("telescope.nvim", function()
            require("telescope").load_extension("undo")
          end)
        end,
      },
    },
    keys = {
      { "<leader><space>", string.format("<cmd>%s<cr>", commands.telescope.file_browser), desc = "File Browser" },
      { "<leader>su", string.format("<cmd>%s<cr>", commands.telescope.undo), desc = "Undo Tree" },
    },
    opts = {
      defaults = {
        -- Content
        -- path_display = { "smart" },
        dynamic_preview_title = true,

        --- Layout
        layout_strategy = "flex",
        layout_config = {
          width = 0.90,
          height = 0.90,
          flex = {
            flip_columns = 140,
          },
        },
        -- winblend = 5,
        wrap_results = true,
      },
      pickers = {
        buffers = {
          sort_mru = true,
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        oldfiles = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        projects = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        find_files = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        git_files = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        reloader = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        -- man_pages = { sections = { "2", "3" } },
        -- lsp_references = { path_display = { "shorten" } },
        lsp_document_symbols = { path_display = { "hidden" } },
        lsp_workspace_symbols = { path_display = { "shorten" } },
        -- lsp_code_actions = {},
        -- current_buffer_fuzzy_find = {},
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
          auto_depth = true,
          collapse_dirs = true,
          cwd_to_path = true,
          grouped = true,
          hidden = true,
          hide_parent_dir = true,
          hijack_netrw = true,
          prompt_path = true,
          -- respect_gitignore = false,
          select_buffer = true,
        },
        undo = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
        yank_history = {
          theme = "ivy",
          layout_config = {
            prompt_position = "bottom",
          },
        },
      },
    },
  },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    keys = function()
      return {}
    end,
  },

  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "TextChanged" },
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      -- local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- sources
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))

      -- borders
      opts.window = {
        completion = cmp.config.window.bordered(cmp_window_options),
        documentation = cmp.config.window.bordered(cmp_window_options),
      }

      -- disable preselect
      opts.preselect = cmp.PreselectMode.None
      opts.completion.completeopt = "menu,menuone,preview,noinsert,noselect"
      opts.completion.autocomplete = {
        cmp.TriggerEvent.TextChanged,
        cmp.TriggerEvent.InsertEnter,
      }

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),

        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),

        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.select_prev_item()
          -- elseif luasnip.jumpable(-1) then
          --   luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        -- If nothing is selected (including preselections) add a newline as usual.
        -- If something has explicitly been selected by the user, select it.
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        }),
      })
    end,
  },
}
