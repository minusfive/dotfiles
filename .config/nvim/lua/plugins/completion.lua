---@param idx number
local function get_keymap_for_idx(idx)
  -- Only show for the first 10 items
  if idx > 10 then return end
  return "M-" .. (idx % 10)
end

local function get_indexed_keymap()
  ---@type blink.cmp.KeymapConfig
  local keymap = { preset = "super-tab", ["<C-S-y>"] = { "select_and_accept" } }

  -- Add indexed selection keymaps
  for i = 1, 10 do
    local idx_keymap = get_keymap_for_idx(i)
    if not idx_keymap then break end

    keymap["<" .. idx_keymap .. ">"] = {
      function(cmp) cmp.accept({ index = i }) end,
    }
  end

  return keymap
end

return {
  -- Copilot Broken: https://github.com/zbirenbaum/copilot.lua/issues/408#issuecomment-2758411881
  { "zbirenbaum/copilot.lua", commit = "99654fe9ad6cb2500c66b178a03326f75c95f176" },

  {
    "saghen/blink.cmp",
    optional = true,
    -- dev = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        menu = {
          draw = {
            align_to = "label",
            treesitter = { "lsp" },
            columns = {
              { "item_idx" },
              { "label", "label_description", gap = 1 },
              { "kind_icon", "source_name", gap = 1 },
            },
            components = {
              -- Add indexed selection keymaps hints
              item_idx = {
                text = function(ctx) return get_keymap_for_idx(ctx.idx) end,
                highlight = "BlinkCmpItemIdx",
              },
            },
          },
        },
      },

      keymap = get_indexed_keymap(),

      -- signature = { enabled = true },

      -- TODO: Explore other ways of reverting overrides?
      -- Force enable commandline completion
      cmdline = vim.tbl_deep_extend("force", {}, require("blink.cmp.config").cmdline, {
        keymap = get_indexed_keymap(),
        completion = {
          menu = { auto_show = true },
          ghost_text = { enabled = true },
        },
      }),

      sources = {
        providers = {
          copilot = {
            score_offset = 0,
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
    keys = function() return {} end,
  },
}
