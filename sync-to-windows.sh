#!/bin/bash

echo "🔄 Sincronizando configurações WSL → Windows..."

# Cores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Função para copiar arquivo com verificação
sync_file() {
    local source="$1"
    local dest="$2"
    local desc="$3"
    
    echo -e "${BLUE}📋 Sincronizando: ${desc}${NC}"
    
    if [ -f "$source" ]; then
        # Criar diretório de destino se não existir
        dest_dir=$(dirname "$dest")
        mkdir -p "$dest_dir" 2>/dev/null || true
        
        # Copiar arquivo
        if cp "$source" "$dest" 2>/dev/null; then
            echo -e "   ${GREEN}✅ Copiado: $source → $dest${NC}"
        else
            echo -e "   ${YELLOW}⚠️  Erro ao copiar para: $dest${NC}"
            # Tentar copiar para backup local
            backup_name="/home/joao/config/backup-$(basename "$source")"
            if cp "$source" "$backup_name"; then
                echo -e "   ${GREEN}✅ Backup criado: $backup_name${NC}"
            fi
        fi
    else
        echo -e "   ${RED}❌ Arquivo fonte não encontrado: $source${NC}"
    fi
    echo ""
}

# Sincronizar .zshrc
sync_file "$HOME/.zshrc" "/home/joao/config/zshrc" "Configuração Zsh"

# Tentar sincronizar arquivos do Windows (pode não funcionar diretamente via script)
echo -e "${YELLOW}⚠️  Para sincronizar com Windows, execute manualmente:${NC}"
echo "1. VSCode Settings:"
echo "   cp ~/.config/Code/User/settings.json /mnt/c/Users/valor/AppData/Roaming/Code/User/settings.json"
echo ""
echo "2. VSCode Keybindings:"
echo "   cp ~/.config/Code/User/keybindings.json /mnt/c/Users/valor/AppData/Roaming/Code/User/keybindings.json"
echo ""
echo "3. Windows Terminal:"
echo "   # Copiar manualmente através do Explorer ou PowerShell"
echo ""

# Criar backups locais dos arquivos importantes
echo -e "${BLUE}📦 Criando backups locais...${NC}"

# Backup das configurações existentes
for config_file in bashrc zshenv p10k.zsh gitconfig profile fzf.bash fzf.zsh; do
    if [ -f "/home/joao/config/$config_file" ]; then
        echo -e "   ${GREEN}✅ Backup existente: $config_file${NC}"
    fi
done

echo ""
echo -e "${GREEN}🎉 Sincronização concluída!${NC}"
echo -e "${BLUE}📌 Próximos passos:${NC}"
echo "   1. Verificar backups em /home/joao/config/"
echo "   2. Sincronizar manualmente arquivos do Windows"
echo "   3. Testar configurações nos dois ambientes"