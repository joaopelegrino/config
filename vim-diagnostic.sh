#!/bin/bash

# 🔍 Script de Diagnóstico Vim - Status da Configuração
# Autor: Sistema de configurações centralizadas
# Data: 06/08/2025

echo "🔍 DIAGNÓSTICO VIM - Status da Configuração"
echo "=" $(printf '%.0s' {1..50})

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $1${NC}"
    else
        echo -e "${RED}❌ $1${NC}"
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

echo
echo "📋 1. VERIFICAÇÕES BÁSICAS"
echo "-" $(printf '%.0s' {1..30})

# Verificar se Vim está instalado
vim --version > /dev/null 2>&1
print_status "Vim instalado e funcionando"

# Versão do Vim
VIM_VERSION=$(vim --version | head -1 | cut -d' ' -f5)
print_info "Versão: $VIM_VERSION"

# Verificar configuração centralizada
if [ -L ~/.vimrc ]; then
    print_status "Link simbólico ~/.vimrc configurado"
    VIMRC_TARGET=$(readlink ~/.vimrc)
    print_info "Aponta para: $VIMRC_TARGET"
else
    print_warning "Link simbólico ~/.vimrc não encontrado"
fi

echo
echo "📁 2. ESTRUTURA DE DIRETÓRIOS"
echo "-" $(printf '%.0s' {1..30})

# Diretório .vim
if [ -d ~/.vim ]; then
    print_status "Diretório ~/.vim existe"
else
    print_warning "Diretório ~/.vim não encontrado"
fi

# Diretório undodir
if [ -d ~/.vim/undodir ]; then
    print_status "Undo persistente configurado"
    UNDO_FILES=$(ls ~/.vim/undodir | wc -l)
    print_info "Arquivos de undo: $UNDO_FILES"
else
    print_warning "Diretório undodir não encontrado"
fi

# Diretório spell
if [ -d ~/.vim/spell ]; then
    print_status "Diretório spell existe"
    SPELL_FILES=$(ls ~/.vim/spell | wc -l)
    print_info "Arquivos de spell: $SPELL_FILES"
else
    print_warning "Diretório spell não encontrado"
fi

echo
echo "🔌 3. SISTEMA DE PLUGINS"
echo "-" $(printf '%.0s' {1..30})

# Plugin manager
if [ -f ~/.vim/autoload/plug.vim ]; then
    print_status "vim-plug instalado"
else
    print_warning "vim-plug não encontrado"
fi

# Diretório de plugins
if [ -d ~/.vim/plugged ]; then
    PLUGIN_COUNT=$(ls ~/.vim/plugged | wc -l)
    print_status "$PLUGIN_COUNT plugins detectados em ~/.vim/plugged"
    
    # Listar plugins encontrados
    print_info "Plugins instalados:"
    for plugin in ~/.vim/plugged/*/; do
        if [ -d "$plugin" ]; then
            plugin_name=$(basename "$plugin")
            echo "    - $plugin_name"
        fi
    done
else
    print_warning "Diretório ~/.vim/plugged não encontrado"
fi

# Verificar se plugins são carregados no vimrc
if grep -q "call plug#begin" ~/.vimrc 2>/dev/null; then
    print_status "Plugin manager ativo no vimrc"
else
    print_warning "Plugin manager NÃO ativo no vimrc"
fi

echo
echo "⚙️ 4. CONFIGURAÇÕES PRINCIPAIS"
echo "-" $(printf '%.0s' {1..30})

# Tamanho do vimrc
if [ -f ~/.vimrc ]; then
    VIMRC_SIZE=$(wc -l < ~/.vimrc)
    print_status "vimrc carregado ($VIMRC_SIZE linhas)"
else
    print_warning "Arquivo vimrc não encontrado"
fi

# Verificar configurações chave
if grep -q "set termguicolors" ~/.vimrc 2>/dev/null; then
    print_status "True color configurado"
fi

if grep -q "set undofile" ~/.vimrc 2>/dev/null; then
    print_status "Undo persistente ativo"
fi

if grep -q "colorscheme" ~/.vimrc 2>/dev/null; then
    COLORSCHEME=$(grep "colorscheme" ~/.vimrc | grep -v "^\s*\"" | tail -1 | cut -d' ' -f2)
    print_status "Tema configurado: $COLORSCHEME"
fi

if grep -q "statusline" ~/.vimrc 2>/dev/null; then
    print_status "Statusline personalizada"
fi

echo
echo "🧪 5. TESTES FUNCIONAIS"
echo "-" $(printf '%.0s' {1..30})

# Teste básico de carregamento
vim -c 'echo "Test OK"' -c 'q' > /dev/null 2>&1
print_status "Carregamento básico do Vim"

# Teste de syntax highlighting
vim -c 'syntax on' -c 'q' > /dev/null 2>&1
print_status "Syntax highlighting funcional"

# Teste de colorscheme
vim -c "colorscheme $COLORSCHEME" -c 'q' > /dev/null 2>&1
if [ $? -eq 0 ]; then
    print_status "Tema carrega sem erros"
else
    print_warning "Problema com tema $COLORSCHEME"
fi

echo
echo "📊 6. ESTATÍSTICAS"
echo "-" $(printf '%.0s' {1..30})

# Configuração centralizada
print_info "Localização: /home/joao/config/vimrc"

# Espaço ocupado
VIM_SIZE=$(du -sh ~/.vim 2>/dev/null | cut -f1)
print_info "Espaço ocupado: $VIM_SIZE"

# Última modificação do vimrc
if [ -f ~/.vimrc ]; then
    LAST_MODIFIED=$(stat -c %y ~/.vimrc | cut -d' ' -f1)
    print_info "Última modificação: $LAST_MODIFIED"
fi

echo
echo "🎯 7. RECOMENDAÇÕES"
echo "-" $(printf '%.0s' {1..30})

# Verificar se plugins estão ativos
if [ -d ~/.vim/plugged ] && ! grep -q "call plug#begin" ~/.vimrc 2>/dev/null; then
    echo -e "${RED}❗ CRÍTICO: Plugins instalados mas não carregados${NC}"
    echo -e "${YELLOW}   Solução: Adicionar configuração vim-plug ao vimrc${NC}"
    echo -e "${BLUE}   Consulte: /home/joao/config/vim-README.md${NC}"
fi

# Verificar versão do Vim
VIM_MAJOR=$(echo $VIM_VERSION | cut -d'.' -f1)
if [ "$VIM_MAJOR" -lt 8 ]; then
    echo -e "${YELLOW}   Recomendação: Atualizar Vim para versão 8.0+${NC}"
fi

# Sugestões gerais
echo -e "${GREEN}✨ Para melhorar a configuração:${NC}"
echo "   1. Ativar sistema de plugins (ver README)"
echo "   2. Configurar language servers para LSP"
echo "   3. Personalizar keybindings para workflow"

echo
echo "📖 DOCUMENTAÇÃO COMPLETA: /home/joao/config/vim-README.md"
echo "🔧 Para implementar melhorias, siga o roteiro no README"
echo
echo "Diagnóstico concluído em $(date)"
