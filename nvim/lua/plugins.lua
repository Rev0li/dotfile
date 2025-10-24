local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", 
        "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

-- ════════════════════════════════════════
-- 🎨 Thèmes / ColorSchemes
-- ════════════════════════════════════════
    { "folke/tokyonight.nvim" },
    { "catppuccin/nvim", name = "catppuccin" },
    { "EdenEast/nightfox.nvim" },
    { "rose-pine/neovim", name = "rose-pine" },
    { "morhetz/gruvbox" },

-- ════════════════════════════════════════
-- 🗂️ File Explorer
-- ════════════════════════════════════════
    { "kyazdani42/nvim-tree.lua" },

-- ════════════════════════════════════════
-- ⚙️ Mason (installation des LSP binaires)
-- ════════════════════════════════════════
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
            
            -- Installer automatiquement les LSP au premier lancement
            vim.api.nvim_create_autocmd("User", {
                pattern = "MasonToolsUpdateCompleted",
                callback = function()
                    vim.notify("✓ LSP installés", vim.log.levels.INFO)
                end,
            })
        end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "clangd",      -- C/C++
                    "pyright",     -- Python
                    "lua-language-server",  -- Lua
                    "typescript-language-server",  -- JavaScript/TypeScript
                },
                auto_update = false,
                run_on_start = true,
            })
        end,
    },

-- ════════════════════════════════════════
-- 🌳 Treesitter (highlight + indentation)
-- ════════════════════════════════════════
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

-- ════════════════════════════════════════
-- 📏 Indentation visuelle
-- ════════════════════════════════════════
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│" },
            whitespace = {
                highlight = { "Whitespace" },
                remove_blankline_trail = false,
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            },
        },
    },

-- ════════════════════════════════════════
-- 🔍 Fuzzy Finder (Telescope)
-- ════════════════════════════════════════
    {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("telescope").setup({})
        end
    },

-- ════════════════════════════════════════
-- 📊 Barre d'état (Lualine)
-- ════════════════════════════════════════
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    section_separators = '',
                    component_separators = '',
                    globalstatus = true,
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {},
                    lualine_c = { { 'filename', path = 1 } },
                    lualine_x = {},
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end
    },

-- ════════════════════════════════════════
-- 🔄 Autopairs (parenthèses, crochets, etc.)
-- ════════════════════════════════════════
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },

-- ════════════════════════════════════════
-- ⌨️ Affichage des raccourcis (Which-key)
-- ════════════════════════════════════════
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end
    },

-- ════════════════════════════════════════
-- 🚀 Dashboard d'accueil (Alpha)
-- ════════════════════════════════════════
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("dashboard")
        end
    },

-- ════════════════════════════════════════
-- 💬 Fenêtres flottantes UI (Dressing)
-- ════════════════════════════════════════
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                enabled = true,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            select = {
                enabled = true,
                backend = { "telescope", "builtin" },
                trim_prompt = true,
                builtin = {
                    border = "rounded",
                    winblend = 10,
                },
            },
        }
    },
	
-- ════════════════════════════════════════
-- 🔀 Git Conflict Resolution
-- ════════════════════════════════════════
{
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
        require('git-conflict').setup({
            default_mappings = true,        -- Active les raccourcis par défaut
            default_commands = true,        -- Active les commandes par défaut
            disable_diagnostics = false,    -- Garde les diagnostics activés
            list_opener = 'copen',          -- Commande pour ouvrir la quickfix list
            highlights = {
                incoming = 'DiffAdd',
                current = 'DiffText',
            }
        })
    end
},

-- ════════════════════════════════════════
--  HEADER 42 
-- ════════════════════════════════════════
	{
		"Diogo-ss/42-header.nvim",
		cmd = { "Stdheader" },
		keys = { "<F1>" },
		opts = {
			default_map = true, -- Active le mapping par défaut (F1)
			auto_update = true, -- Met à jour automatiquement le header lors de la sauvegarde
			user = "okientzl", -- Remplace par ton login 42
			mail = "okientzl@student.42lyon.fr", -- Remplace par ton email 42
		},
		config = function(_, opts)
			require("42header").setup(opts)
		end,
	}
})

