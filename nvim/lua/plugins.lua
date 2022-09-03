vim.cmd[[packadd packer.nvim]]

-- SEE: https://qiita.com/delphinus/items/8160d884d415d7425fcc

require'packer'.startup(function()
  use'tpope/vim-fugitive'
  use'tpope/vim-repeat'

  use{'wbthomason/packer.nvim', opt = true}

  use{'rhysd/git-messenger.vim', opt = true, cmd = {'GitMessenger'}}

  use{'tpope/vim-unimpaired', opt = true, event = {'FocusLost', 'CursorHold'}}

  use{'fatih/vim-go', opt = true, ft = {'go'}}
end)
