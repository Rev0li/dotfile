-- ════════════════════════════════════════
-- 🔌 Chargement de LSPConfig et des capacités LSP
-- ════════════════════════════════════════
local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- ════════════════════════════════════════
-- 🧠 Configuration générique des LSP (sauf clangd)
-- ════════════════════════════════════════
local servers = { "pyright", "lua_ls" }

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

-- ════════════════════════════════════════
-- ⚙️ Configuration personnalisée pour clangd (C/C++)
-- ════════════════════════════════════════
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--compile-commands-dir=.", "--header-insertion=never" },
  args = { "-Iinclude" },
  root_dir = lspconfig.util.root_pattern(".git", ".clangd", "Makefile"),
})

-- ════════════════════════════════════════
-- 🌀 Configuration spécifique à lua_ls (pour Neovim)
-- ════════════════════════════════════════
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
    },
  },
})
