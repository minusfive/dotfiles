local unpack = unpack or table.unpack

local cmp_window_options = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
}

return {
  {
    "saghen/blink.cmp",
    optional = true,
    -- dev = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        -- TODO: LazyVim keymap <TAB> override doesn't respect manual
        list = {
          -- selection = "auto_insert",
        },

        menu = {
          max_height = 15,

          draw = {
            treesitter = { "lsp" },
            columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
            components = {
              item_idx = {
                text = function(ctx)
                  return tostring(ctx.idx)
                end,
                highlight = "BlinkCmpItemIdx",
              },
            },
          },
        },
      },

      keymap = {
        preset = "default",
        -- cmdline = { preset = "super-tab" },
        ["<Up>"] = require("blink.cmp.keymap.presets").enter["<Up>"],
        ["<Down>"] = require("blink.cmp.keymap.presets").enter["<Down>"],

        ["<M-1>"] = {
          function(cmp)
            cmp.accept({ index = 1 })
          end,
        },
        ["<M-2>"] = {
          function(cmp)
            cmp.accept({ index = 2 })
          end,
        },
        ["<M-3>"] = {
          function(cmp)
            cmp.accept({ index = 3 })
          end,
        },
        ["<M-4>"] = {
          function(cmp)
            cmp.accept({ index = 4 })
          end,
        },
        ["<M-5>"] = {
          function(cmp)
            cmp.accept({ index = 5 })
          end,
        },
        ["<M-6>"] = {
          function(cmp)
            cmp.accept({ index = 6 })
          end,
        },
        ["<M-7>"] = {
          function(cmp)
            cmp.accept({ index = 7 })
          end,
        },
        ["<M-8>"] = {
          function(cmp)
            cmp.accept({ index = 8 })
          end,
        },
        ["<M-9>"] = {
          function(cmp)
            cmp.accept({ index = 9 })
          end,
        },
        ["<M-0>"] = {
          function(cmp)
            cmp.accept({ index = 10 })
          end,
        },
      },

      signature = { enabled = true },

      sources = {
        -- TODO: Explore other ways of reverting overrides?
        -- Force enable commandline completion
        cmdline = require("blink.cmp.config.sources").default.cmdline,
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

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    event = { "InsertEnter", "TextChanged" },
    dependencies = {
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

      -- Lower copilot priority
      if opts.sources[1].name == "copilot" then
        opts.sources[1].group_index = 2
      end

      -- borders
      opts.window = {
        completion = cmp.config.window.bordered(cmp_window_options),
        documentation = cmp.config.window.bordered(cmp_window_options),
      }

      -- disable preselect
      opts.preselect = cmp.PreselectMode.None
      opts.completion.completeopt = "menu,menuone,preview,noinsert,noselect"

      -- Trigger completion upon typing and entering insert mode
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
