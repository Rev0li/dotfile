-- -- ════════════════════════════════════════
-- -- 🔌 Chargement de LSPConfig et des capacités LSP
-- -- ════════════════════════════════════════
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- -- ════════════════════════════════════════
-- -- 🧠 Configuration générique des LSP (sauf clangd)
-- -- ════════════════════════════════════════
local servers = { "pyright", "lua_ls" }
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

-- -- ════════════════════════════════════════
-- -- ⚙️ Configuration personnalisée pour clangd (C/C++)
-- -- ════════════════════════════════════════
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--compile-commands-dir=.", "--header-insertion=never" },
  args = { "-Iinclude" },
  root_dir = vim.fs.root(0, { ".git", ".clangd", "Makefile" }),
})

-- -- ════════════════════════════════════════
-- --   Configuration spécifique pour Pyright (recommandé)
-- -- ════════════════════════════════════════
vim.lsp.config("pyright", {
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        extraPaths = { "./src" },
      },
    },
  },
  root_dir = vim.fs.root(0, {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    ".git",
    "src",
  }),
})

-- -- ════════════════════════════════════════
-- -- 🌀 Configuration spécifique à lua_ls (pour Neovim)
-- -- ════════════════════════════════════════
vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

