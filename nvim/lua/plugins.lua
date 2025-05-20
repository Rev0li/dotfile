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
-- ⚙️ LSP & Mason
-- ════════════════════════════════════════
    {
        "williamboman/mason.nvim",
        config = function() require("mason").setup() end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        version = "1.29.0",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "clangd", "pyright", "lua_ls" },
            })
        end,
    },
    { "neovim/nvim-lspconfig" },

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
-- 🤖 Autocomplétion (nvim-cmp)
-- ════════════════════════════════════════
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip"
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- ['<Tab>'] = cmp.mapping.select_next_item(),
                    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })
        end
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
    }

})

