local vault_name = "Personal"
local vault_path_relative = "~/Notes/" .. vault_name
local vault_path_absolute = vim.fn.expand(vault_path_relative)

---@param title string|?
---@return string
local title_id = function(title)
  local new_title = ""
  if title ~= nil then
    -- If title is given, transform it into valid file name.
    new_title = title:gsub("[^A-Za-z0-9-]", "")
  else
    -- If title is nil, just add 4 random uppercase letters to the suffix.
    for _ = 1, 4 do
      new_title = new_title .. string.char(math.random(65, 90))
    end
  end
  return new_title
end

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      defaults = {
        ["<leader>n"] = { name = "+new" },
      },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- optional = true,
    -- lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      "VeryLazy",
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      -- Personal
      "BufReadPre "
        .. vault_path_absolute
        .. "/**.md",
      "BufNewFile " .. vault_path_absolute .. "/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>nn", "<cmd>vsplit & ObsidianNew<cr>", desc = "Note (Obsidian)", remap = true },
    },
    opts = {
      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",

      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
      },

      -- A list of workspace names, paths, and configuration overrides.
      -- If you use the Obsidian app, the 'path' of a workspace should generally be
      -- your vault root (where the `.obsidian` folder is located).
      -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
      -- the workspace to the first workspace in the list whose `path` is a parent of the
      -- current markdown file being edited.
      workspaces = {
        {
          name = vault_name,
          path = vault_path_relative,
        },
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "Journal",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        -- alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        -- default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "Note Template.md",
      },
      -- Optional, for templates (see below).
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      -- Optional, configure additional syntax highlighting / extmarks.
      -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
      ui = {
        enable = false, -- set to false to disable all additional syntax features
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
      },

      -- Optional, customize how note IDs are generated given an optional title.
      note_id_func = title_id,
    },
  },
}
