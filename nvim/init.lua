bufOpen = {"BufNewFile", "BufRead"}

-- Runtimepath
vim.opt.runtimepath:append {"$HOME/dotfiles/nvim"}

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

-- Color Scheme
vim.opt.background = "dark"
vim.cmd [[ colorscheme hybrid ]]

-- Transparency
for key, value in pairs({ "Normal", "NonText", "LineNr", "Folded", "EndOfBuffer" }) do
  vim.api.nvim_set_hl(0, value, { ctermbg="none"})
end

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

-- Packer.nvim
require 'plugins'
vim.cmd[[autocmd BufWritePost lua/plugins.lua PackerCompile]]

-- fzf-lua
vim.api.nvim_set_keymap('n', '<c-P>', "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })


-- bultin-lsp
--
-- SEE: https://zenn.dev/nazo6/articles/c2f16b07798bab
-- SEE: https://github.com/neovim/nvim-lspconfig
-- SEE: https://github.com/williamboman/mason.nvim
local on_attach = function(client, bufnr)
  local set = vim.keymap.set
  
  set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
  set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  set("n", "<space>h", "<cmd>lua vim.lsp.buf.hover()<CR>")
  set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")

  set("n", "<C-k>", "<cmd>lua vm.lsp.buf.signature_help()<CR>")

  set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
  set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
  set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
end

-- mason (external dependency installer for lsp)
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach
    }
  end,
}


-- nvim-cmp
-- SEE: https://zenn.dev/nazo6/articles/c2f16b07798bab
capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require "cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})


-- caw
-- "Ctrl-k => Single-Line Comment Out
-- "Ctrl-c => Wrapped Comment Out
map_key('n', '<C-k>', '<Plug>(caw:hatpos:toggle)')
map_key('v', '<C-k>', '<Plug>(caw:hatpos:toggle)')
map_key('n', '<C-c>', '<Plug>(caw:wrap:toggle)')
map_key('v', '<C-c>', '<Plug>(caw:wrap:toggle)')

