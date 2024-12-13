-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local buftypes_non_file = { "terminal", "quickfix", "nofile", "prompt", "help" }

---@param ev vim.api.create_autocmd.callback.args
---@return boolean
local function is_non_file_buffer(ev)
  return vim.list_contains(buftypes_non_file, vim.bo[ev.buf].buftype)
end

local aug_minusfive = vim.api.nvim_create_augroup("minusfive", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  desc = "Use relative numbers",
  group = aug_minusfive,
  callback = function(ev)
    if is_non_file_buffer(ev) then
      return
    end

    vim.wo.relativenumber = true
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  desc = "Use absolute numbers",
  group = aug_minusfive,
  callback = function(ev)
    if is_non_file_buffer(ev) then
      return
    end

    vim.wo.relativenumber = false
  end,
})

-- Disable diagnostics on .env files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = { "*.env", "*.env.*" },
  desc = "Disable diagnostics on .env files",
  group = aug_minusfive,
  callback = function(ev)
    if vim.bo.filetype == "sh" then
      vim.diagnostic.enable(false, { bufnr = ev.buf })
    end
  end,
})

-- To instead override globally
-- local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
-- function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
--   opts = opts or {}
--   opts.border = opts.border or "rounded"
--   return orig_util_open_floating_preview(contents, syntax, opts, ...)
-- end
vim.diagnostic.open_float = (function(original_fn)
  return function(opts)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    -- local opts = {
    --   focusable = false,
    --   close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --   border = "rounded",
    --   source = "always",
    --   prefix = " ",
    --   scope = "cursor",
    -- }
    return original_fn(opts)
  end
end)(vim.diagnostic.open_float)
