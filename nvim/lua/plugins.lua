vim.cmd[[packadd packer.nvim]]

-- SEE: https://qiita.com/delphinus/items/8160d884d415d7425fcc

-- Commands
-- :PackerInstall
--
-- :PackerCompile
-- 
-- :PackerUpdate
-- 
-- :PackerSync
--
-- :PackerClean

require'packer'.startup(function()
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'

  -- Package Manager
  use { 'wbthomason/packer.nvim', opt = true }

  -- Git
  use { 'rhysd/git-messenger.vim', opt = true, cmd = {'GitMessenger'} }

  use { 'tpope/vim-unimpaired', opt = true, event = {'FocusLost', 'CursorHold'} }

  use { 'fatih/vim-go', opt = true, ft = {'go'} }

  -- Fuzzy Finder
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  
  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
        
  -- formatter
  use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }

  -- cmp
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/vim-vsnip"

  -- comment out
  use 'tyru/caw.vim'
end)
