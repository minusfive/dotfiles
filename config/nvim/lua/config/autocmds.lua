-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Use absolute numbers in `insert` mode and hide cursorline on leave
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  callback = function()
    -- vim.opt.relativenumber = true
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  callback = function()
    -- vim.opt.relativenumber = false
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})
-- Open diagnostics on cursor hold
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = "rounded",
--       source = "always",
--       prefix = " ",
--       scope = "cursor",
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end,
-- })
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
