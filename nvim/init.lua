bufOpen = {"BufNewFile", "BufRead"}

-- Temporary Runtimepath
vim.opt.runtimepath:append {"$HOME/dev/projects/nvim-remaster/.config/nvim"}

-- Lazy Redraw
vim.o.lazyredraw = true

-- Search Config
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wrapscan = true

-- Defualt Indent
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- backspace behaviour
vim.o.backspace = 'indent,eol,start'

-- clipboard 
vim.o.clipboard = "unnamedplus"


-- 行番号
vim.o.number = true
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern="*",
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { cterm=499, bold=true })   
  end,
})

-- vim.api.nvim_create_autocmd(bufOpen, {
--   callback = function()
--     vim.api.nvim_exec("ColorScheme * highlight LineNr ctermfg=499")
--   end
-- })

-- Ftplugin
mk_tab_size = function(size)
  return string.format("setlocal tabstop=%d shiftwidth=%d softtabstop=%d", size, size, size)
end

---- Lua
vim.api.nvim_create_augroup("lua", {})
vim.api.nvim_create_autocmd(bufOpen, {
  group = "lua",
  pattern = { "*.lua" },
  callback = function()
    vim.api.nvim_exec(mk_tab_size(2), false)
  end
})



-- Key map utiltity
map_key = function(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true, silent = true })
end


-- Quickfix(cw)
---- preview file by p key 
map_key('n', 'p', '<CR>zz<C-w>p')
-- vim.api.nvim_set_keymap('n', 'p', '<CR>zz<C-w>p', { noremap = true })


-- Packer.nvim
require 'plugins'
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
