vim.cmd[[packadd packer.nvim]]

packer = require 'packer'
packer.init {
	opt_default = true,
	display  = {
		open_fn = require('packer.util').float,
	}
}

local use = packer.use
packer.reset()

packer.startup(function()

	use {
		'wbthomason/packer.nvim',
		opt = false
	}

	-- vim
	use 'junegunn/vim-easy-align'
	use 'mattn/emmet-vim'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use 'vim-scripts/httplog'
	use 'will133/vim-dirdiff'
	use 'triglav/vim-visual-increment'
	use 'drewtempelmeyer/palenight.vim'
	use 'kshenoy/vim-sol'
	use 'mhartington/oceanic-next'
	use 'sainnhe/sonokai'
	use 'franbach/miramare'
end)
