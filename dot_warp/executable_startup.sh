#!/bin/bash
# Warp Terminal Startup Configuration
# Previne conflitos de notebook creation

export WARP_NOTEBOOK_PATH="$HOME/.warp/notebooks"
export WARP_CONFIG_PATH="$HOME/.warp"
export WARP_DISABLE_SSH_WRAPPER=${WARP_DISABLE_SSH_WRAPPER:-0}

# Garantir que diretórios existem
[ ! -d "$WARP_NOTEBOOK_PATH" ] && mkdir -p "$WARP_NOTEBOOK_PATH"
[ ! -d "$WARP_CONFIG_PATH" ] && mkdir -p "$WARP_CONFIG_PATH"

# Log para debug
echo "Warp startup: $(date)" >> "$WARP_CONFIG_PATH/startup.log"
