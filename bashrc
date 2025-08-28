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
