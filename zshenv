# ~/.zshenv: carregado para TODOS os tipos de shell zsh
# Definir apenas variáveis de ambiente essenciais aqui

# NVM Directory - definir antes de outros scripts
export NVM_DIR="$HOME/.nvm"

# Configurações de linguagem
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8

# Configurações de histórico do Zsh
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
. "$HOME/.cargo/env"
