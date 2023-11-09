-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- mouse
vim.opt.mousemoveevent = true

-- blinking cursor
vim.opt.guicursor = {
  "n-v:block-blinkwait175-blinkoff150-blinkon175",
  "i-c-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
  "i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- don't hide stuff from me
vim.opt.conceallevel = 0

-- soft wrap
vim.o.showbreak = "╰╴"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat:append("_")
vim.opt.breakindent = true
vim.opt.breakindentopt:append({ "shift:2", "sbr" })
vim.opt.cpoptions:append("n")

-- keep cursorline in the middle
vim.opt.scrolloff = 999

-- nvim
vim.g.minipairs_disable = true

-- filetypes
vim.filetype.add({
  -- extension = {
  --   conf = "conf",
  --   env = "sh",
  --   tiltfile = "tiltfile",
  --   Tiltfile = "tiltfile",
  -- },
  -- filename = {
  --   [".env"] = "sh",
  --   ["tsconfig.json"] = "jsonc",
  --   [".yamlfmt"] = "yaml",
  -- },
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
    ["%.gitconfig%.[%w_.-]+"] = "gitconfig",
  },
})
