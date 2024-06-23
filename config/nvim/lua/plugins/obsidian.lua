return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  optional = true,
  lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    -- Personal
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/Notes/Personal/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Notes/Personal/**.md",
    -- ADSK
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/Notes/ADSK/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Notes/ADSK/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
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
        name = "Personal",
        path = "~/Notes/Personal",
      },
      {
        name = "ADSK",
        path = "~/Notes/ADSK",
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
  },
}
