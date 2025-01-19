vim.env.LAZY_STDPATH = ".repro"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

---@diagnostic disable-next-line: missing-fields
require("lazy.minit").repro({
  spec = {
    { "folke/snacks.nvim", opts = { picker = { enabled = true } } },
  },
})
