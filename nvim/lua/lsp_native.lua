-- ════════════════════════════════════════
-- 📦 Configuration LSP native (Neovim 0.11+)
-- Sans plugin nvim-lspconfig
-- ════════════════════════════════════════

-- ════════════════════════════════════════
-- 🔧 Configuration globale pour tous les LSP
-- ════════════════════════════════════════

vim.lsp.config('*', {
  -- Capacités communes (autocomplétion)
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  
  -- Root markers par défaut
  root_markers = { '.git' },
})

-- ════════════════════════════════════════
-- 🔧 Configuration des LSP par langage
-- ════════════════════════════════════════

-- ─────────────────────────────────────────────
-- C/C++ (clangd)
-- ─────────────────────────────────────────────
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--header-insertion=never',
    '--fallback-style=none',
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.clangd',
    'Makefile',
  },
})

-- ─────────────────────────────────────────────
-- Python (pyright)
-- ─────────────────────────────────────────────
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
  },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'workspace',
      },
    },
  },
})

-- ─────────────────────────────────────────────
-- JavaScript/TypeScript (ts_ls)
-- ─────────────────────────────────────────────
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

-- ─────────────────────────────────────────────
-- Lua (lua_ls)
-- ─────────────────────────────────────────────
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- ════════════════════════════════════════
-- 🚀 Activation automatique des LSP
-- ════════════════════════════════════════

-- Activer les LSP pour les filetypes correspondants
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'objc', 'objcpp' },
  callback = function()
    vim.lsp.enable('clangd')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.lsp.enable('pyright')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function()
    vim.lsp.enable('ts_ls')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.lsp.enable('lua_ls')
  end,
})

-- ════════════════════════════════════════
-- ⌨️ Keybindings LSP (activés automatiquement)
-- ════════════════════════════════════════

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = { buffer = args.buf, silent = true }
    
    -- Keymaps
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    
    -- Autocomplétion (native Neovim 0.11+)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
    
    -- Notification
    if client then
      vim.notify('✓ LSP attaché: ' .. client.name, vim.log.levels.INFO)
    end
  end,
})

-- ════════════════════════════════════════
-- 💬 Configuration des diagnostics
-- ════════════════════════════════════════

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

-- Symboles des diagnostics dans la gutter
local signs = { Error = '✘', Warn = '▲', Hint = '⚑', Info = '»' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ════════════════════════════════════════
-- 🛠️ Commandes utiles pour C/C++
-- ════════════════════════════════════════

-- Créer compile_flags.txt depuis le Makefile (C99)
vim.api.nvim_create_user_command('CreateCompileFlags', function()
  local flags = {}
  local makefile = io.open('Makefile', 'r')

  if makefile then
    for line in makefile:lines() do
      local found = line:match('CFLAGS%s*=%s*(.+)') or 
                    line:match('CPPFLAGS%s*=%s*(.+)') or
                    line:match('CXXFLAGS%s*=%s*(.+)')
      if found then
        for flag in found:gmatch('%S+') do
          table.insert(flags, flag)
        end
      end
    end
    makefile:close()
  end

  if #flags == 0 then
    flags = {
      '-Wall',
      '-Wextra',
      '-Werror',
      '-std=c99',
      '-I./includes',
      '-I./include',
      '-I.',
    }
    vim.notify('⚠️ Aucun CFLAGS trouvé, flags par défaut (C99) utilisés', vim.log.levels.WARN)
  else
    vim.notify('✓ Flags extraits du Makefile', vim.log.levels.INFO)
  end

  local file = io.open('compile_flags.txt', 'w')
  if file then
    for _, flag in ipairs(flags) do
      file:write(flag .. '\n')
    end
    file:close()
    vim.notify('✓ compile_flags.txt créé', vim.log.levels.INFO)
  else
    vim.notify('❌ Impossible d\'écrire compile_flags.txt', vim.log.levels.ERROR)
  end
end, { desc = 'Créer compile_flags.txt depuis le Makefile (C99)' })

-- Créer compile_flags.txt pour C++98
vim.api.nvim_create_user_command('CreateCompileFlagsCpp', function()
  local flags = {
    '-Wall',
    '-Wextra',
    '-Werror',
    '-std=c++98',
    '-I./includes',
    '-I./include',
    '-I.',
  }

  local file = io.open('compile_flags.txt', 'w')
  if file then
    for _, flag in ipairs(flags) do
      file:write(flag .. '\n')
    end
    file:close()
    vim.notify('✓ compile_flags.txt créé (C++98)', vim.log.levels.INFO)
  else
    vim.notify('❌ Impossible d\'écrire compile_flags.txt', vim.log.levels.ERROR)
  end
end, { desc = 'Créer compile_flags.txt pour C++98' })

-- ════════════════════════════════════════
-- 📝 Aide-mémoire
-- ════════════════════════════════════════
--[[
Configuration LSP native (sans plugin) :
  vim.lsp.config()  - Configurer un LSP
  vim.lsp.enable()  - Activer un LSP
  :checkhealth vim.lsp - Vérifier la config

Raccourcis LSP :
  gd          - Aller à la définition
  gD          - Aller à la déclaration
  gi          - Aller à l'implémentation
  gr          - Voir les références
  K           - Documentation (hover)
  <leader>rn  - Renommer
  <leader>ca  - Actions de code
  <leader>f   - Formater le code
  [d          - Diagnostic précédent
  ]d          - Diagnostic suivant
  <leader>e   - Afficher diagnostic

Commandes :
  :CreateCompileFlags     - Créer compile_flags.txt (C99)
  :CreateCompileFlagsCpp  - Créer compile_flags.txt (C++98)
  :LspInfo                - Info sur les LSP actifs
  :LspRestart             - Redémarrer le LSP
]]
