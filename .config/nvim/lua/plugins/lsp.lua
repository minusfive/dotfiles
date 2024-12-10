---Retrieves an LSP client by name
---@param name string
---@return vim.lsp.Client | nil
local function getLSPClient(name)
  return vim.lsp.get_clients({ bufnr = 0, name = name })[1]
end

---Toggles an LSP client by name
---@param name string
---@return nil
local function toggleLSPClient(name)
  local client = getLSPClient(name)
  if client then
    client.stop(true)
  else
    vim.cmd("LspStart " .. name)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    ---@param opts PluginLspOpts
    opts = function(_, opts)
      ---@type PluginLspOpts
      local lspconfigOptions = {
        inlay_hints = { enabled = false },
        servers = {
          harper_ls = {
            autostart = false,
            settings = {
              ["harper-ls"] = {
                userDictPath = "~/.config/harper/dictionaries/user.txt",
                fileDictPath = "~/.config/harper/dictionaries/files/",
                codeActions = { forceStable = true },
              },
            },
          },
        },
        setup = {
          harper_ls = function()
            Snacks.toggle({
              name = "Grammar Checker",
              get = function()
                return getLSPClient("harper_ls") ~= nil
              end,
              set = function()
                toggleLSPClient("harper_ls")
              end,
            }):map("<leader>clg")
          end,
        },
      }

      LazyVim.merge(opts, lspconfigOptions)

      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "<leader>cl", false }
      keys[#keys + 1] = { "<leader>cli", "<cmd>LspInfo<cr>", desc = "Info" }

      require("which-key").add({
        { "<leader>cl", group = "LSP", icon = LazyVim.config.icons.diagnostics.Info },
      })
    end,
  },
}
