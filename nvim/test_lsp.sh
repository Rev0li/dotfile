#!/bin/bash
# Script de test pour vérifier que les LSP fonctionnent

echo "🧪 Test de la configuration LSP"
echo ""

# Créer un dossier de test
TEST_DIR="/tmp/nvim_lsp_test"
rm -rf "$TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo "📁 Dossier de test : $TEST_DIR"
echo ""

# Test Python
echo "🐍 Test Python..."
cat > test.py << 'EOF'
def hello(name):
    """Fonction de test"""
    print(f"Hello {name}")

hello("World")
EOF

# Test C
echo "🔧 Test C..."
cat > test.c << 'EOF'
#include <stdio.h>

int main(void)
{
    printf("Hello World\n");
    return (0);
}
EOF

# Créer compile_flags.txt pour C
cat > compile_flags.txt << 'EOF'
-Wall
-Wextra
-Werror
-std=c99
EOF

# Test JavaScript
echo "📜 Test JavaScript..."
cat > test.js << 'EOF'
function hello(name) {
    console.log(`Hello ${name}`);
}

hello("World");
EOF

# Test TypeScript
echo "📘 Test TypeScript..."
cat > test.ts << 'EOF'
function hello(name: string): void {
    console.log(`Hello ${name}`);
}

hello("World");
EOF

# Créer package.json pour JS/TS
cat > package.json << 'EOF'
{
  "name": "test",
  "version": "1.0.0"
}
EOF

echo ""
echo "✅ Fichiers de test créés !"
echo ""
echo "📝 Pour tester :"
echo "  cd $TEST_DIR"
echo "  nvim test.py    # Test Python"
echo "  nvim test.c     # Test C"
echo "  nvim test.js    # Test JavaScript"
echo "  nvim test.ts    # Test TypeScript"
echo ""
echo "🔍 Dans Neovim, vérifie :"
echo "  - Coloration syntaxique (Treesitter)"
echo "  - Message 'LSP attaché: <nom>'"
echo "  - Autocomplétion (Ctrl+Space)"
echo "  - Hover (K sur une fonction)"
echo ""
