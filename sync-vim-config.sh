#!/bin/bash

# Script para sincronizar a estrutura completa do Vim para ~/config/
# Mantém links simbólicos do sistema apontando para ~/config/

set -e  # Sair em caso de erro

CONFIG_DIR="$HOME/config"
VIM_DIR="$CONFIG_DIR/vim"
BACKUP_DIR="$CONFIG_DIR/vim-backup-$(date +%Y%m%d-%H%M%S)"

echo "========================================="
echo "Sincronização da Configuração do Vim"
echo "========================================="
echo ""

# Função para criar backup
create_backup() {
    if [ -d "$VIM_DIR" ]; then
        echo "📦 Criando backup da configuração existente..."
        cp -r "$VIM_DIR" "$BACKUP_DIR"
        echo "✅ Backup criado em: $BACKUP_DIR"
    fi
}

# Função para verificar estrutura atual
check_current_structure() {
    echo "🔍 Verificando estrutura atual do Vim..."
    echo ""
    
    # Verificar .vimrc
    if [ -L "$HOME/.vimrc" ]; then
        echo "📄 ~/.vimrc é um link simbólico para: $(readlink $HOME/.vimrc)"
    elif [ -f "$HOME/.vimrc" ]; then
        echo "📄 ~/.vimrc existe como arquivo regular"
    else
        echo "❌ ~/.vimrc não encontrado"
    fi
    
    # Verificar .vim/
    if [ -L "$HOME/.vim" ]; then
        echo "📁 ~/.vim é um link simbólico para: $(readlink $HOME/.vim)"
    elif [ -d "$HOME/.vim" ]; then
        echo "📁 ~/.vim existe como diretório regular"
        echo "   Conteúdo: $(ls -1 $HOME/.vim | wc -l) itens"
    else
        echo "❌ ~/.vim não encontrado"
    fi
    
    echo ""
}

# Função para criar estrutura em ~/config/
create_config_structure() {
    echo "📂 Criando estrutura do Vim em ~/config/..."
    
    # Criar diretório vim em config se não existir
    mkdir -p "$VIM_DIR"
    
    # Copiar toda a estrutura .vim para config/vim/
    if [ -d "$HOME/.vim" ] && [ ! -L "$HOME/.vim" ]; then
        echo "📋 Copiando ~/.vim para $VIM_DIR..."
        
        # Copiar preservando estrutura e permissões
        cp -rp "$HOME/.vim/." "$VIM_DIR/"
        
        echo "✅ Estrutura copiada com sucesso!"
    elif [ -L "$HOME/.vim" ]; then
        echo "⚠️  ~/.vim já é um link simbólico, pulando cópia..."
    fi
    
    # Verificar e copiar vimrc se necessário
    if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
        echo "📋 Copiando ~/.vimrc para $CONFIG_DIR/vimrc..."
        cp -p "$HOME/.vimrc" "$CONFIG_DIR/vimrc"
    fi
    
    echo ""
}

# Função para criar links simbólicos
create_symlinks() {
    echo "🔗 Criando links simbólicos..."
    
    # Backup dos arquivos originais se existirem
    if [ -d "$HOME/.vim" ] && [ ! -L "$HOME/.vim" ]; then
        echo "📦 Fazendo backup de ~/.vim original..."
        mv "$HOME/.vim" "$HOME/.vim.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    
    if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
        echo "📦 Fazendo backup de ~/.vimrc original..."
        mv "$HOME/.vimrc" "$HOME/.vimrc.backup-$(date +%Y%m%d-%H%M%S)"
    fi
    
    # Remover links antigos se existirem
    [ -L "$HOME/.vim" ] && rm "$HOME/.vim"
    [ -L "$HOME/.vimrc" ] && rm "$HOME/.vimrc"
    
    # Criar novos links simbólicos
    ln -s "$VIM_DIR" "$HOME/.vim"
    ln -s "$CONFIG_DIR/vimrc" "$HOME/.vimrc"
    
    echo "✅ Links simbólicos criados!"
    echo "   ~/.vim -> $VIM_DIR"
    echo "   ~/.vimrc -> $CONFIG_DIR/vimrc"
    echo ""
}

# Função para verificar resultado final
verify_result() {
    echo "✔️  Verificando configuração final..."
    echo ""
    
    # Testar links
    if [ -L "$HOME/.vim" ] && [ -d "$(readlink -f $HOME/.vim)" ]; then
        echo "✅ ~/.vim está corretamente linkado"
    else
        echo "❌ Problema com link ~/.vim"
    fi
    
    if [ -L "$HOME/.vimrc" ] && [ -f "$(readlink -f $HOME/.vimrc)" ]; then
        echo "✅ ~/.vimrc está corretamente linkado"
    else
        echo "❌ Problema com link ~/.vimrc"
    fi
    
    # Listar estrutura
    echo ""
    echo "📊 Estrutura em ~/config/vim/:"
    tree -L 2 "$VIM_DIR" 2>/dev/null || ls -la "$VIM_DIR"
    
    echo ""
    echo "📊 Arquivos Vim em ~/config/:"
    ls -la "$CONFIG_DIR" | grep -i vim || echo "Nenhum arquivo vim encontrado"
}

# Função principal
main() {
    echo "Este script irá:"
    echo "1. Copiar toda estrutura ~/.vim para ~/config/vim/"
    echo "2. Copiar ~/.vimrc para ~/config/vimrc"
    echo "3. Criar links simbólicos apontando para ~/config/"
    echo ""
    read -p "Deseja continuar? (s/N): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Operação cancelada."
        exit 0
    fi
    
    echo ""
    check_current_structure
    create_backup
    create_config_structure
    create_symlinks
    verify_result
    
    echo ""
    echo "========================================="
    echo "✅ Sincronização concluída com sucesso!"
    echo "========================================="
    echo ""
    echo "📝 Notas importantes:"
    echo "• Toda configuração do Vim agora está em ~/config/"
    echo "• ~/.vim e ~/.vimrc são links simbólicos"
    echo "• Backups foram criados com timestamp se necessário"
    echo "• Para reverter, remova os links e restaure os backups"
}

# Executar
main
