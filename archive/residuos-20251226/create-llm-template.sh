#!/bin/bash

# Script para criar templates LLM-main.md com substituições automáticas
# Uso: ./create-llm-template.sh [nome-arquivo] [tarefa-descricao]

set -e

# Configurações
TEMPLATE_SOURCE="/home/notebook/workspace/blog/.claude/commands/LLM-main.md"
DEFAULT_NAME="LLM-$(date +%Y%m%d-%H%M).md"
TARGET_DIR="/home/notebook/workspace/blog/.claude/commands"

# Argumentos
FILENAME="${1:-$DEFAULT_NAME}"
TASK_DESC="${2:-Nova tarefa de desenvolvimento}"

# Arquivo de destino
if [[ "$FILENAME" == *"/"* ]]; then
    TARGET_FILE="$FILENAME"
else
    TARGET_FILE="$TARGET_DIR/$FILENAME"
fi

# Verificar se template existe
if [[ ! -f "$TEMPLATE_SOURCE" ]]; then
    echo "❌ Template não encontrado: $TEMPLATE_SOURCE"
    exit 1
fi

echo "🔧 Criando novo arquivo LLM a partir do template..."
echo "📁 Origem: $TEMPLATE_SOURCE"
echo "📄 Destino: $TARGET_FILE"
echo "📝 Tarefa: $TASK_DESC"

# Copiar template
cp "$TEMPLATE_SOURCE" "$TARGET_FILE"

# Substituições automáticas (opcional)
if command -v sed >/dev/null 2>&1; then
    # Substituir placeholders se fornecidos
    if [[ "$#" -ge 2 ]]; then
        # Substituir primeira linha da tarefa
        sed -i "/^Em uma nova branch/c\\$TASK_DESC" "$TARGET_FILE"
    fi

    # Adicionar timestamp
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "" >> "$TARGET_FILE"
    echo "<!-- Criado automaticamente em $TIMESTAMP -->" >> "$TARGET_FILE"
fi

echo "✅ Template criado com sucesso!"
echo "📂 Arquivo: $TARGET_FILE"

# Abrir no Vim se disponível
if command -v vim >/dev/null 2>&1; then
    echo "🚀 Abrindo no Vim..."
    vim "$TARGET_FILE"
else
    echo "💡 Para editar: vim \"$TARGET_FILE\""
fi