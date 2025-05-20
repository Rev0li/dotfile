local lspconfig = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Handlers globaux sauf clangd
local servers = { "pyright", "lua_ls" }

for _, server in ipairs(servers) do
  lspconfig[server].setup({ capabilities = capabilities })
end

-- clangd avec config custom
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--compile-commands-dir=.", "--header-insertion=never" },
  args = { "-Iinclude" },
  root_dir = lspconfig.util.root_pattern(".git", ".clangd", "Makefile"),
})

-- LuaLS spécifique
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
