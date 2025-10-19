# Configuração do FZF para ZSH no WSL
# Este arquivo deve ser copiado para ~/.fzf.zsh

# Adicionar FZF ao PATH se não estiver presente
if [[ ! "$PATH" == */home/$USER/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/$USER/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/$USER/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/$USER/.fzf/shell/key-bindings.zsh"

# Detectar se estamos em WSL
if grep -q "microsoft" /proc/version 2>/dev/null; then
  export FZF_IS_WSL=1
else
  export FZF_IS_WSL=0
fi

# Configurações para WSL específicas e default
# Usar fd em vez de find se disponível (mais rápido)
if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type directory --follow --hidden --exclude .git --exclude node_modules'
else
  # Fallback para find
  export FZF_CTRL_T_COMMAND="find . -type f -not -path '*/\.git/*' -not -path '*/node_modules/*'"
  export FZF_ALT_C_COMMAND="find . -type d -not -path '*/\.git/*' -not -path '*/node_modules/*'"
fi

# Melhorar o comando de preview para diferentes tipos de arquivo
if command -v bat >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (ls -la {})) || echo {} 2> /dev/null | head -200'"
else
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline --preview '([[ -f {} ]] && cat {}) || ([[ -d {} ]] && ls -la {}) || echo {} 2> /dev/null | head -200'"
fi

# Configuração de Preview otimizada
export FZF_CTRL_T_OPTS="--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} 2>/dev/null || cat {})) || ([[ -d {} ]] && (ls -la {} | sort)) || echo {} 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--preview 'ls -la {} | sort'"

# Melhorar o histórico de comandos sem preview (causa problemas em alguns terminais)
export FZF_CTRL_R_OPTS="--preview '' --preview-window hidden"

# Definir TERM corretamente para Windows Terminal
if [[ "$FZF_IS_WSL" -eq 1 ]]; then
  export TERM=xterm-256color
fi

# Fix para problemas de input no Windows Terminal + WSL
if [[ "$FZF_IS_WSL" -eq 1 ]]; then
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --no-mouse"
fi
