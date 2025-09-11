# ~/.bashrc: executado pelo bash para shells não-login
# Este arquivo deve ser copiado para ~/.bashrc

# Se não for interativo, não fazer nada
case $- in
    *i*) ;;
      *) return;;
esac

# Não armazenar linhas duplicadas ou linhas começando com espaço no histórico
HISTCONTROL=ignoreboth

# Anexar ao arquivo de histórico, não sobrescrever
shopt -s histappend

# Tamanho do histórico
HISTSIZE=1000
HISTFILESIZE=2000

# Verificar o tamanho da janela após cada comando
shopt -s checkwinsize

# Fazer o less mais amigável para arquivos não-texto
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Definir um prompt colorido
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Habilitar suporte a cores para ls e outros comandos
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alguns aliases úteis
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias update='sudo apt update && sudo apt upgrade -y'

# Função para criar e entrar em um diretório
function mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Habilitar autocompletion do bash
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Carregar FZF se existir
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Aliases para Laravel Sail (se você usa Laravel)
alias s='./vendor/bin/sail'

# Suporte a NVM (Node Version Manager) - descomente se você usar
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Definir o editor padrão
export EDITOR=vim
. "$HOME/.cargo/env"
export PATH="/opt/elixir-1.15.7/bin:$PATH"
export ELIXIR_ERL_OPTIONS="+fnu"
export PATH="$HOME/.local/bin:$HOME/.fzf/bin:$PATH"

# === Aliases de Produtividade ===
# Git aliases
alias gst="git status -sb"
alias gco="git checkout"
alias gcm="git commit -m"
alias glog="git log --oneline --graph --decorate"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"

# Navegação rápida
alias ws="cd ~/workspace"
alias conf="cd ~/config"
alias learning="cd ~/workspace/learning"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

# Desenvolvimento
alias py="python3"
alias reload="source ~/.bashrc"

# Função para usar FZF se disponível
if [ -f ~/.fzf/bin/fzf ]; then
    export PATH="$HOME/.fzf/bin:$PATH"
    export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'
fi
# ASDF Version Manager
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Kiex (Elixir version manager)
test -s "$KIEX_HOME/scripts/kiex" && source "$KIEX_HOME/scripts/kiex"

# Projeto-BM Debug Workflow Aliases (Added by otimizacao-claude-code)
alias debug-projeto-bm="echo '🔍 Running Projeto-BM Visual Debug...' && node .claude/projeto-bm-visual-debug-integration.js"
alias test-complete="echo '🧪 Running Complete Test Suite...' && ./.claude/projeto-bm-test-suite.sh"
alias observatory="echo '🎯 Checking Observatory Dashboard...' && curl -s http://localhost:4000/claude/dashboard"
alias health-check="echo '❤️ Checking API Health...' && curl -s http://localhost:4000/api/health | jq"

# Pre-delivery validation function
pre_delivery_check() {
    echo "🔍 Running Projeto-BM Complete Validation..."
    echo "============================================="
    
    local validation_failed=0
    
    # Check if server is running
    if ! curl -s --connect-timeout 3 http://localhost:4000/api/health >/dev/null 2>&1; then
        echo "❌ Phoenix server not running. Start with: mix phx.server"
        return 1
    fi
    
    # 1. Visual Debug (screenshots + network + performance)
    echo "📸 Step 1/3: Visual Debug Validation..."
    if ! timeout 180s node .claude/projeto-bm-visual-debug-integration.js; then
        echo "❌ Visual debug failed. Do not mark as 'finalizado'"
        validation_failed=1
    else
        echo "✅ Visual debug completed successfully"
    fi
    
    # 2. Complete test suite (10 categories)
    echo "🧪 Step 2/3: Complete Test Suite..."
    if ! ./.claude/projeto-bm-test-suite.sh; then  
        echo "❌ Test suite failed. Review before delivery"
        validation_failed=1
    else
        echo "✅ Test suite completed successfully"
    fi
    
    # 3. Observatory health check
    echo "🎯 Step 3/3: Observatory Health Check..."
    if ! curl -s http://localhost:4000/claude/dashboard >/dev/null 2>&1; then
        echo "⚠️ Observatory not accessible. Consider reviewing metrics"
    else
        echo "✅ Observatory is accessible"
    fi
    
    if [ $validation_failed -eq 0 ]; then
        echo ""
        echo "🎉 PRE-DELIVERY VALIDATION COMPLETE - SUCCESS!"
        echo "📁 Review artifacts in: .claude/screenshots/session-*/"
        echo "✅ Safe to mark as 'finalizado' in roadmaps"
        return 0
    else
        echo ""
        echo "❌ PRE-DELIVERY VALIDATION FAILED"
        echo "🚫 DO NOT mark as 'finalizado' until issues are resolved"
        return 1
    fi
}

# Observatory monitoring function  
check_observatory() {
    echo "🎯 Observatory Status Check..."
    echo "============================="
    
    # Dashboard check
    if curl -s http://localhost:4000/claude/dashboard >/dev/null 2>&1; then
        echo "✅ Dashboard: http://localhost:4000/claude/dashboard"
    else
        echo "❌ Dashboard not accessible"
    fi
    
    # API Health check
    if curl -s http://localhost:4000/api/claude/hooks/health >/dev/null 2>&1; then
        echo "✅ API Health: http://localhost:4000/api/claude/hooks/health"
    else
        echo "❌ API Health not accessible"
    fi
    
    # Recent screenshots check
    local recent_screenshots=$(find .claude/screenshots/ -name "*.png" -mtime -1 2>/dev/null | wc -l)
    echo "📸 Recent screenshots (24h): $recent_screenshots"
    
    # Recent sessions check
    local recent_sessions=$(find .claude/screenshots/ -name "session-*" -mtime -1 2>/dev/null | wc -l)
    echo "📊 Recent debug sessions (24h): $recent_sessions"
}

# Environment variables
export PLAYWRIGHT_BROWSERS_PATH="/tmp/playwright-browsers"
export CLAUDE_DEBUG_LEVEL="verbose"  
export PROJETO_BM_AUTO_DEBUG="true"
export CLAUDE_VISUAL_VALIDATION="enabled"

echo "✅ Projeto-BM Debug Workflow configured!"
echo ""
echo "Available commands:"
echo "  debug-projeto-bm     - Run visual debug validation"
echo "  test-complete        - Run complete test suite"
echo "  observatory          - Check Observatory dashboard"
echo "  health-check         - Check API health with JSON"
echo "  pre_delivery_check   - Complete pre-delivery validation"
echo "  check_observatory    - Observatory status overview"
echo ""
