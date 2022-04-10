vim.cmd[[packadd packer.nvim]]

packer = require 'packer'
packer.init {
	opt_default = false,
	display  = {
		open_fn = require('packer.util').float,
	}
}

local use = packer.use
-- packer.reset()
packer.startup(function()
	use {'wbthomason/packer.nvim', opt = false}
	use 'junegunn/vim-easy-align'
	use 'tpope/vim-commentary'
	use 'tpope/vim-surround'
	use {'mattn/emmet-vim', ft = {'html', 'html', 'tpl'}}
	use {'vim-scripts/httplog', opt = true, ft = {'log'}}
	use 'will133/vim-dirdiff'
	use 'triglav/vim-visual-increment'
	use 'sheerun/vim-polyglot' -- language pack
	use 'markonm/traces.vim' -- substitute
	use 'liuchengxu/vista.vim' -- structure view
	use 'blueyed/smarty.vim'
	use 'norcalli/nvim-colorizer.lua'
	use {'nvim-treesitter/nvim-treesitter', run = [[:TSUpdate]]} -- We recommend updating the parsers on update
	use 'neovim/nvim-lspconfig'
	use 'plasticboy/vim-markdown'
	use 'shawncplus/phpcomplete.vim'
	use 'vim-scripts/PDV--phpDocumentor-for-Vim'
	use 'liuchengxu/vim-clap'
	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use "williamboman/nvim-lsp-installer"
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
	use 'glepnir/lspsaga.nvim'
	-- colorscheme
	use 'drewtempelmeyer/palenight.vim'
	use 'EdenEast/nightfox.nvim'
	use 'kshenoy/vim-sol'
	use 'kyazdani42/nvim-web-devicons' -- for file icons
end)