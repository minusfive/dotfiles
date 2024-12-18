local unpack = unpack or table.unpack

local cmp_window_options = {
  winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:Search",
}

local cmp_idx_mod_key = "M"

---@param idx number
local function get_num_key_for_idx(idx)
  return idx == 10 and 0 or idx
end

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
          draw = {
            align_to_component = "kind_icon",
            padding = 0,
            treesitter = { "lsp" },
            columns = {
              { "item_idx" },
              { "kind_icon", "label", "label_description", gap = 1 },
              { "source_name" },
            },
            components = {
              item_idx = {
                text = function(ctx)
                  local num_key = get_num_key_for_idx(ctx.idx)
                  return cmp_idx_mod_key .. "-" .. num_key
                end,
                highlight = "BlinkCmpItemIdx",
              },
            },
          },
        },
      },

      keymap = (function()
        ---@type blink.cmp.KeymapConfig
        local keymap = {
          preset = "default",
          -- cmdline = { preset = "super-tab" },
          ["<Up>"] = require("blink.cmp.keymap.presets").enter["<Up>"],
          ["<Down>"] = require("blink.cmp.keymap.presets").enter["<Down>"],
        }

        -- Add indexed selection keymaps
        for i = 1, 10 do
          local num_key = get_num_key_for_idx(i)
          keymap["<" .. cmp_idx_mod_key .. "-" .. num_key .. ">"] = {
            function(cmp)
              cmp.accept({ index = i })
            end,
          }
        end

        return keymap
      end)(),

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
