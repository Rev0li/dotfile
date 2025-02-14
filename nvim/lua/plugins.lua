-- plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	-- Themes
	{ "folke/tokyonight.nvim" },                     -- Thème Tokyo Night
	{ "catppuccin/nvim",         name = "catppuccin" }, -- Thème Catppuccin
	{ "EdenEast/nightfox.nvim" },                    -- Thème Nightfox
	{ "rose-pine/neovim",        name = "rose-pine" }, -- Thème Rose Pine
	{ "morhetz/gruvbox" },
	---------------------------------
	-- Tree toggle for switch fasted
	{ "kyazdani42/nvim-tree.lua" },
	---------------------------------
	-- Gestionnaire de serveurs LSP
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	---------------------------------
	-- Mason load lang color indent
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "pyright", "lua_ls" },
				automatic_installation = true,
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	---------------------------------
	-- Plug in terminal float
	{
		"voldikss/vim-floaterm",
		config = function()
			vim.g.floaterm_position = "bottom" -- Position en bas
			vim.g.floaterm_height = 0.3 --30% de la hauteur de l'écran
		end,
	},
	---------------------------------
	-- Plug in telescope for search my file
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false, -- Désactiver Clear
							["<C-d>"] = false, -- Désactiver Scroll down
						},
					},
				},
			})
		end
	},
	--------------------------------
	-- Better visibilite Mode (Normal, Insert, Terminal ect...)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = { theme = "auto" }
			})
		end
	},
	---------------------------------
	-- auto pair {}
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end
	},
	---------------------------------
	-- For learn my shortcut, pop up when press leader "\"
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end
	}

})
