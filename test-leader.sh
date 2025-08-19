#!/bin/bash

echo "🧪 TESTE DA LEADER KEY - Comandos com vírgula (,)"
echo "================================================"

# Criar arquivo de teste
TEST_FILE="/tmp/vim_leader_test.txt"
cat > "$TEST_FILE" << 'EOF'
Este é um arquivo de teste para leader key.
Teste os seguintes comandos no modo NORMAL:

,w    - Salvar arquivo
,s    - Toggle spell check  
,n    - Toggle line numbers
,l    - Toggle listchars
,wr   - Toggle wrap

INSTRUÇÕES:
1. Pressione ESC para garantir modo NORMAL
2. Digite vírgula seguida da tecla (sem espaço)
3. Aguarde 500ms para o comando executar
4. Use :q para sair

Git commands (se estiver em um repositório):
,gs   - Git status
,ga   - Git add .
,gc   - Git commit
,gp   - Git push
EOF

echo "✅ Arquivo de teste criado: $TEST_FILE"
echo ""
echo "🚀 Para testar, execute:"
echo "   vim $TEST_FILE"
echo ""
echo "📋 Dentro do Vim:"
echo "   1. Pressione ESC (modo normal)"  
echo "   2. Digite: ,w (salvar)"
echo "   3. Digite: ,s (toggle spell)"
echo "   4. Digite: ,n (toggle numbers)"
echo "   5. Digite: ,q (sair)"
echo ""
echo "❗ IMPORTANTE: Comandos só funcionam em modo NORMAL (após ESC)"

# Fazer arquivo executável
chmod +x "$0"
