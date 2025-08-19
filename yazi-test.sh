#!/bin/bash

# ⚡ Script de Teste do Yazi - Ambiente de Desenvolvimento
# Testa as configurações e integrações do Yazi

echo "🚀 Testando configuração do Yazi..."
echo "=========================================="

# Verifica se o Yazi está instalado
echo "1. Verificando instalação do Yazi..."
if command -v yazi &> /dev/null; then
    echo "✅ Yazi encontrado: $(which yazi)"
    yazi --version
else
    echo "❌ Yazi não encontrado no PATH"
    exit 1
fi

echo ""

# Verifica arquivos de configuração
echo "2. Verificando arquivos de configuração..."

CONFIG_DIR="/home/joao/.config/yazi"
if [ -d "$CONFIG_DIR" ]; then
    echo "✅ Diretório de configuração existe: $CONFIG_DIR"
    
    # Lista arquivos de configuração
    echo "📁 Arquivos de configuração encontrados:"
    ls -la "$CONFIG_DIR"
else
    echo "❌ Diretório de configuração não encontrado"
fi

echo ""

# Verifica arquivos específicos
echo "3. Verificando arquivos específicos..."

files=(
    "yazi.toml:Configuração principal"
    "keymap.toml:Mapeamento de teclas"
    "theme.toml:Tema personalizado"
)

for file_desc in "${files[@]}"; do
    IFS=':' read -r file desc <<< "$file_desc"
    if [ -f "$CONFIG_DIR/$file" ]; then
        echo "✅ $desc: $CONFIG_DIR/$file"
        echo "   Tamanho: $(stat -c%s "$CONFIG_DIR/$file") bytes"
        echo "   Modificado: $(stat -c%y "$CONFIG_DIR/$file")"
    else
        echo "❌ $desc não encontrado: $CONFIG_DIR/$file"
    fi
done

echo ""

# Verifica dependências opcionais
echo "4. Verificando dependências opcionais..."

deps=(
    "fd:Busca rápida de arquivos"
    "rg:Busca em conteúdo (ripgrep)"
    "fzf:Fuzzy finder"
    "bat:Visualizador de código"
    "eza:Listagem de arquivos moderna"
    "git:Controle de versão"
    "vim:Editor de texto"
    "code:VS Code"
)

for dep_desc in "${deps[@]}"; do
    IFS=':' read -r cmd desc <<< "$dep_desc"
    if command -v "$cmd" &> /dev/null; then
        echo "✅ $desc: $(which $cmd)"
    else
        echo "⚠️  $desc não encontrado (opcional): $cmd"
    fi
done

echo ""

# Testa função yy() do zsh
echo "5. Verificando integração com shell..."
if [ -n "$ZSH_VERSION" ]; then
    echo "✅ Executando em ZSH"
    if declare -f yy > /dev/null; then
        echo "✅ Função yy() está carregada (integração cd)"
    else
        echo "⚠️  Função yy() não encontrada - reinicie o shell"
    fi
else
    echo "ℹ️  Shell atual: $SHELL (não é ZSH)"
fi

echo ""

# Testa aliases
echo "6. Verificando aliases do Yazi..."
aliases=(
    "y:Alias para yazi"
    "fm:Alias para file manager"
    "yc:Yazi config directory"
    "yw:Yazi workspace directory"
    "yh:Yazi home directory"
)

for alias_desc in "${aliases[@]}"; do
    IFS=':' read -r alias_name desc <<< "$alias_desc"
    if alias "$alias_name" &> /dev/null; then
        echo "✅ $desc: $(alias $alias_name)"
    else
        echo "⚠️  $desc não encontrado: $alias_name"
    fi
done

echo ""

# Verifica cache e diretórios de trabalho
echo "7. Verificando diretórios de cache..."
CACHE_DIR="/home/joao/.cache/yazi"
if [ -d "$CACHE_DIR" ]; then
    echo "✅ Cache do Yazi: $CACHE_DIR"
    echo "   Conteúdo: $(ls -la "$CACHE_DIR" 2>/dev/null | wc -l) itens"
else
    echo "ℹ️  Cache será criado automaticamente em: $CACHE_DIR"
fi

echo ""

# Verifica completions do zsh
echo "8. Verificando completions..."
COMPLETION_FILE="/usr/share/zsh/site-functions/_yazi"
if [ -f "$COMPLETION_FILE" ]; then
    echo "✅ Completions do ZSH instalados: $COMPLETION_FILE"
else
    echo "⚠️  Completions não encontrados (não crítico)"
fi

echo ""

# Teste básico de funcionalidade
echo "9. Teste básico de funcionalidade..."
if yazi --help > /dev/null 2>&1; then
    echo "✅ Yazi responde a comandos básicos"
else
    echo "❌ Yazi não responde adequadamente"
fi

echo ""

# Resumo e instruções
echo "🎯 RESUMO E PRÓXIMOS PASSOS"
echo "=========================================="
echo ""
echo "✅ Para usar o Yazi:"
echo "   • Digite 'yazi' ou 'y' para abrir"
echo "   • Use 'yy' para navegar com cd integrado"
echo "   • Atalhos: 'yc' (config), 'yw' (workspace), 'yh' (home)"
echo ""
echo "⌨️  Atalhos principais no Yazi:"
echo "   • j/k: navegar para baixo/cima"
echo "   • h/l: voltar/entrar em diretório"
echo "   • o: abrir arquivo"
echo "   • ,v: abrir com Vim"
echo "   • ,c: abrir com VS Code"
echo "   • s: buscar arquivos (fd)"
echo "   • S: buscar conteúdo (ripgrep)"
echo "   • q: sair"
echo "   • ~: ajuda completa"
echo ""
echo "🔧 Se algo não funcionar:"
echo "   • Reinicie o terminal: exec zsh"
echo "   • Recarregue configurações: source ~/.zshrc"
echo "   • Execute novamente: $0"
echo ""

# Status final
if command -v yazi &> /dev/null && [ -f "$CONFIG_DIR/yazi.toml" ]; then
    echo "🎉 Yazi está pronto para uso!"
    exit 0
else
    echo "⚠️  Configuração incompleta - verifique os erros acima"
    exit 1
fi
