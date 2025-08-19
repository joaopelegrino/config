# Configuração do FZF para Bash no WSL
# Este arquivo deve ser copiado para ~/.fzf.bash

# Setup fzf
# ---------
if [[ ! "$PATH" == */home/$USER/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/$USER/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/$USER/.fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/$USER/.fzf/shell/key-bindings.bash"

# WSL-specific configuration
# -------------------------
if grep -q "microsoft" /proc/version 2>/dev/null; then
  # Estamos no WSL
  
  # Usar fd para busca mais rápida se disponível
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type directory --follow --hidden --exclude .git --exclude node_modules'
  else
    # Fallback para find
    export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/\.git/*' -not -path '*/node_modules/*'"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="find . -type d -not -path '*/\.git/*' -not -path '*/node_modules/*'"
  fi
  
  # Configuração de preview
  if command -v bat >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline --no-mouse --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (ls -la {})) || echo {} 2> /dev/null | head -200'"
  else
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline --no-mouse --preview '([[ -f {} ]] && cat {}) || ([[ -d {} ]] && ls -la {}) || echo {} 2> /dev/null | head -200'"
  fi
fi
