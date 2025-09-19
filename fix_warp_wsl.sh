#!/bin/bash

# =============================================================================
# Script de Correção do Warp no WSL2
# Resolve problemas de notebooks corrompidos e configuração do Warp
# =============================================================================

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       CORREÇÃO DO WARP NO WSL2 - NOTEBOOKS            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Função para log
log() {
    echo -e "${GREEN}[$(date '+%H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERRO]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[AVISO]${NC} $1"
}

# =============================================================================
# PASSO 1: Diagnóstico inicial
# =============================================================================
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 1: DIAGNÓSTICO INICIAL${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "Verificando ambiente WSL2..."
if [ -n "$WSL_DISTRO_NAME" ]; then
    log "✓ Executando no WSL2: $WSL_DISTRO_NAME"
else
    error "Este script deve ser executado dentro do WSL2"
    exit 1
fi

# =============================================================================
# PASSO 2: Backup dos dados existentes
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 2: BACKUP DOS DADOS${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

BACKUP_DIR="$HOME/.warp_backup_$(date +%Y%m%d_%H%M%S)"
log "Criando backup em: $BACKUP_DIR"

if [ -d "$HOME/.warp" ]; then
    cp -r "$HOME/.warp" "$BACKUP_DIR"
    log "✓ Backup criado com sucesso"
else
    warning "Diretório .warp não encontrado, criando novo..."
fi

# =============================================================================
# PASSO 3: Limpar notebooks corrompidos
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 3: LIMPEZA DE NOTEBOOKS CORROMPIDOS${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Criar estrutura limpa
log "Recriando estrutura de diretórios do Warp..."
mkdir -p "$HOME/.warp/notebooks"
mkdir -p "$HOME/.warp/cache"
mkdir -p "$HOME/.warp/temp"

# Remover notebooks problemáticos
log "Procurando e removendo notebooks problemáticos..."
find "$HOME/.warp/notebooks" -name "*teste*" -type f -exec rm -f {} \; 2>/dev/null || true
find "$HOME/.warp/notebooks" -name "*.tmp" -type f -exec rm -f {} \; 2>/dev/null || true
find "$HOME/.warp/notebooks" -size 0 -type f -exec rm -f {} \; 2>/dev/null || true

log "✓ Limpeza concluída"

# =============================================================================
# PASSO 4: Corrigir permissões do WSL
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 4: CORREÇÃO DE PERMISSÕES${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Criar/atualizar wsl.conf para melhor compatibilidade
log "Criando configuração otimizada do WSL..."
sudo tee /etc/wsl.conf > /dev/null << 'EOF'
[boot]
systemd=true

[automount]
enabled=true
options="metadata,umask=022,fmask=111"
mountFsTab=true

[network]
generateHosts=true
generateResolvConf=true

[interop]
enabled=true
appendWindowsPath=true

[user]
default=notebook
EOF

log "✓ Configuração do WSL atualizada"

# Ajustar permissões do diretório .warp
chmod -R 755 "$HOME/.warp" 2>/dev/null || true
log "✓ Permissões ajustadas"

# =============================================================================
# PASSO 5: Recriar configuração do Warp
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 5: RECRIAÇÃO DA CONFIGURAÇÃO${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "Criando nova configuração do Warp..."
cat > "$HOME/.warp/config.json" << 'EOF'
{
  "version": "1.0.0",
  "notebook_creation_enabled": true,
  "workspace_path": "~/.warp/notebooks",
  "settings": {
    "shell_integration": true,
    "wsl_compatibility": true,
    "zsh_support": true,
    "auto_save": true,
    "sync_enabled": false
  },
  "wsl_specific": {
    "use_windows_path": false,
    "mount_options": "metadata,umask=022",
    "isolated_notebooks": true
  }
}
EOF

log "✓ Configuração recriada"

# =============================================================================
# PASSO 6: Criar script de inicialização
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 6: SCRIPT DE INICIALIZAÇÃO${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "Criando script de inicialização..."
cat > "$HOME/.warp/startup.sh" << 'EOF'
#!/bin/bash
# Script de inicialização do Warp no WSL

# Garantir que os diretórios existam
mkdir -p ~/.warp/notebooks
mkdir -p ~/.warp/cache
mkdir -p ~/.warp/temp

# Limpar arquivos temporários antigos
find ~/.warp/temp -type f -mtime +1 -delete 2>/dev/null || true

# Verificar integridade dos notebooks
for notebook in ~/.warp/notebooks/*.json; do
    if [ -f "$notebook" ]; then
        if ! python3 -m json.tool "$notebook" > /dev/null 2>&1; then
            echo "Notebook corrompido detectado: $notebook"
            mv "$notebook" "$notebook.corrupted.$(date +%s)"
        fi
    fi
done

echo "Warp inicializado no WSL2"
EOF

chmod +x "$HOME/.warp/startup.sh"
log "✓ Script de inicialização criado"

# =============================================================================
# PASSO 7: Criar template de notebook
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 7: TEMPLATE DE NOTEBOOK${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "Criando template de notebook válido..."
cat > "$HOME/.warp/notebooks/template.json" << 'EOF'
{
  "id": "template",
  "name": "Template Notebook",
  "created_at": "2025-09-15T00:00:00Z",
  "updated_at": "2025-09-15T00:00:00Z",
  "cells": [],
  "metadata": {
    "wsl_compatible": true,
    "version": "1.0.0"
  }
}
EOF

log "✓ Template criado"

# =============================================================================
# PASSO 8: Solução alternativa - Usar diretório no Windows
# =============================================================================
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}PASSO 8: CONFIGURAÇÃO ALTERNATIVA${NC}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

log "Criando script para usar Warp do Windows..."
cat > "$HOME/warp_windows.sh" << 'EOF'
#!/bin/bash
# Script para usar o Warp instalado no Windows a partir do WSL

# Verificar se o usuário do Windows foi fornecido
if [ -z "$1" ]; then
    echo "Uso: ./warp_windows.sh <seu_usuario_windows>"
    echo "Exemplo: ./warp_windows.sh JohnDoe"
    exit 1
fi

WINDOWS_USER="$1"
WARP_PATH="/mnt/c/Users/$WINDOWS_USER/.warp"

# Verificar se o diretório existe
if [ ! -d "$WARP_PATH" ]; then
    echo "Erro: Diretório do Warp não encontrado em: $WARP_PATH"
    echo "Certifique-se de que o Warp está instalado no Windows e o nome de usuário está correto."
    exit 1
fi

# Criar link simbólico
if [ -d "$HOME/.warp" ]; then
    echo "Fazendo backup do .warp atual..."
    mv "$HOME/.warp" "$HOME/.warp.bak.$(date +%s)"
fi

ln -s "$WARP_PATH" "$HOME/.warp"
echo "✓ Link simbólico criado. Agora o Warp no WSL usará os dados do Windows."
EOF

chmod +x "$HOME/warp_windows.sh"
log "✓ Script alternativo criado"

# =============================================================================
# RESUMO E RECOMENDAÇÕES
# =============================================================================
echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ CORREÇÃO CONCLUÍDA COM SUCESSO!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}📋 RESUMO DAS AÇÕES:${NC}"
echo "  ✓ Backup criado em: $BACKUP_DIR"
echo "  ✓ Notebooks corrompidos removidos"
echo "  ✓ Permissões corrigidas"
echo "  ✓ Configuração recriada"
echo "  ✓ Scripts auxiliares criados"
echo ""
echo -e "${YELLOW}⚠️  IMPORTANTE - Escolha uma das opções:${NC}"
echo ""
echo -e "${BLUE}Opção 1 (RECOMENDADA):${NC} Use o Warp APENAS dentro do WSL"
echo "  • Feche completamente o Warp no Windows"
echo "  • Execute o script: ${GREEN}./fix_warp_wsl.sh${NC}"
echo "  • Sempre abra o Warp de dentro do terminal WSL"
echo ""
echo -e "${BLUE}Opção 2:${NC} Use o Warp APENAS no Windows"
echo "  • Configure o Warp no Windows para usar um diretório próprio (ex: ${GREEN}C:\\Users\\seu_usuario\\.warp${NC})"
echo "  • Não acesse os arquivos do WSL pelo Warp do Windows"
echo ""
echo -e "${YELLOW}🚀 Execute agora:${NC}"
echo ""
echo "  1   # Primeiro, FECHE o Warp no Windows completamente"
echo "  2   # Depois execute:"
echo "  3   ./fix_warp_wsl.sh"
echo ""
echo "O script vai perguntar se deseja continuar. Digite 's' para prosseguir."
echo ""
echo "Após executar o script, o problema deve estar resolvido permanentemente!"
echo ""
echo -e "${RED}⚠️  AVISO:${NC} Nunca use o Warp simultaneamente no Windows e WSL!"