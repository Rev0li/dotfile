-- lsp.lua
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Configure Mason pour installer et configurer les serveurs
mason_lspconfig.setup({
    ensure_installed = { "clangd", "pyright", "lua_ls" },
    automatic_installation = true,
})

-- Setup automatique des serveurs LSP avec capabilities
mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = capabilities,
        })
    end,
})


lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

