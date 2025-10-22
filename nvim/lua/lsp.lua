-- ════════════════════════════════════════
-- 📦 Configuration LSP simplifiée
-- ════════════════════════════════════════

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- ════════════════════════════════════════
-- 🔧 Configuration des LSP
-- ════════════════════════════════════════

-- Python
vim.lsp.config("pyright", {
  capabilities = capabilities,
  root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "requirements.txt", ".git" }),
})

-- C/C++
vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { 
    "clangd", 
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed"
  },
  root_dir = vim.fs.root(0, { "compile_commands.json", "compile_flags.txt", ".git", "Makefile" }),
})

-- ════════════════════════════════════════
-- 🚀 ACTIVATION AUTOMATIQUE des LSP
-- ════════════════════════════════════════

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function(ev)
    vim.lsp.enable("pyright")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function(ev)
    vim.lsp.enable("clangd")
  end,
})

-- ════════════════════════════════════════
-- ⌨️ Keybindings (activés automatiquement)
-- ════════════════════════════════════════

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    
    vim.notify("✓ LSP attaché", vim.log.levels.INFO)
  end,
})

-- ════════════════════════════════════════
-- 🛠️ Commande utile pour C/C++
-- ════════════════════════════════════════

vim.api.nvim_create_user_command("CreateCompileFlags", function()
  local flags = {}
  local makefile = io.open("Makefile", "r")

  if makefile then
    for line in makefile:lines() do
      -- Recherche des lignes CFLAGS= ou CPPFLAGS=
      local found = line:match("CFLAGS%s*=%s*(.+)") or line:match("CPPFLAGS%s*=%s*(.+)")
      if found then
        -- Découpe les flags séparés par espace
        for flag in found:gmatch("%S+") do
          table.insert(flags, flag)
        end
      end
    end
    makefile:close()
  end

  -- Si aucun flag trouvé, ajoute des defaults
  if #flags == 0 then
    flags = {
      "-I./includes",
      "-Wall",
      "-Wextra",
      "-Werror",
      "-std=c++98"
    }
    vim.notify("⚠️ Aucun CFLAGS trouvé, flags par défaut utilisés", vim.log.levels.WARN)
  else
    vim.notify("✓ Flags extraits du Makefile", vim.log.levels.INFO)
  end

  -- Écrit dans compile_flags.txt
  local file = io.open("compile_flags.txt", "w")
  if file then
    for _, flag in ipairs(flags) do
      file:write(flag .. "\n")
    end
    file:close()
    vim.notify("✓ compile_flags.txt mis à jour", vim.log.levels.INFO)
  else
    vim.notify("❌ Impossible d'écrire compile_flags.txt", vim.log.levels.ERROR)
  end
end, { desc = "Créer compile_flags.txt depuis le Makefile" })


-- ════════════════════════════════════════
-- 💬 Diagnostics inline à droite du code
-- ════════════════════════════════════════

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",  -- petit point sympa
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
