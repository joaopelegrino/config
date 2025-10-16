# ~/.zshrc
# LIDO APENAS PARA SHELLS ZSH INTERATIVOS

# Suprimir warnings de completion de pacotes não instalados (ex: Docker)
ZSH_DISABLE_COMPFIX=true

# --- SSH Agent Persistente ---
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add ~/.ssh/id_ed25519 2>/dev/null
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
# --- Fim SSH Agent Persistente ---

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Windows Terminal WSL2 - Enable true colors
export COLORTERM=truecolor

# --- Oh My Zsh ---
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
# 'fzf' foi removido daqui pois carregamos manually abaixo com mais controle.
plugins=(
    git
    zsh-autosuggestions
    z # Plugin Z para navegação rápida (requer .z file no home)
    zsh-syntax-highlighting
    zsh-autocomplete # Deve vir DEPOIS de zsh-syntax-highlighting
)

# Carrega Oh My Zsh
source $ZSH/oh-my-zsh.sh
# --- Fim Oh My Zsh ---



# --- Configurações do Usuário ---
# NVM (Node Version Manager) - Carrega nvm, funções e completion
# NVM_DIR é definido em ~/.zshenv
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carrega nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carrega nvm bash_completion para Zsh também


# alias cnvim='p ~/.config/nvim/' # REMOVIDO

# === Vim Initialization Modes ===
alias i='vim -c "source ~/.vimrc"'                                           # Vim normal (padrão completo)
alias it='vim -c "source ~/.vimrc" -c "only" -c "terminal ++curwin"'         # Vim direto no terminal mode
alias iv='vim -u NONE -U NONE --noplugin'                                    # Vim vanilla (sem config/plugins)

alias c='clear'
alias la='ls -A' # Mostra ocultos exceto . e ..
alias ll='ls -alF' # Detalhado, ocultos, indicador de tipo

# --- Carregar Segredos e Variáveis do ~/.env ---
# É crucial que o arquivo ~/.env NÃO esteja no seu repositório Git.
# Adicione .env ao .gitignore do seu repositório `~/config`.
if [[ -f "$HOME/.env" ]]; then
  # Exporta variáveis do tipo VAR=VALOR, ignorando comentários e linhas em branco
  # Usar 'export $(...)' é mais seguro que 'set -a' em alguns casos.
  export $(grep -vE '^\s*(#|$)' "$HOME/.env" | xargs)
  # Verifica se as variáveis esperadas foram carregadas (opcional, mas útil)
  # if [[ -z "$GH" ]]; then
  #   echo "Aviso: Variável GH não encontrada em ~/.env após sourcing." >&2
  # fi
  # if [[ -z "$OPENROUTER_API_KEY" ]]; then
  #   echo "Aviso: Variável OPENROUTER_API_KEY não encontrada em ~/.env após sourcing." >&2
  # fi
else
  # Aviso se o arquivo .env não for encontrado
  echo "Aviso: Arquivo ~/.env não encontrado. Segredos podem estar faltando." >&2
fi
# --- Fim Carregar Segredos ---

# --- Configuração FZF ---
# Carrega configurações, key bindings e completion do FZF.
# As variáveis FZF_* (comandos, opções) devem estar DENTRO de ~/.fzf.zsh
# O path para o binário do fzf é adicionado dentro de ~/.fzf.zsh
[[ -s "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Atalhos FZF Customizados (Opcional - Descomente se necessário e se estiverem DEPOIS do source)
# if [[ "$FZF_IS_WSL" -eq 1 ]] && { [[ "$TERM_PROGRAM" == *"WindowsTerminal"* ]] || [[ -n "$WT_SESSION" ]]; }; then
#    # Exemplo: Usar Ctrl+F em vez de Ctrl+T se Ctrl+T for capturado por outro programa
#    # bindkey '^F' fzf-file-widget
#    # bindkey '^O' fzf-cd-widget
#    # bindkey '^H' fzf-history-widget
# fi
# --- Fim Configuração FZF ---


# --- Funções Customizadas ---
# Função para adicionar um remote do GitHub usando token carregado do ~/.env
remoteadd() {
  local repo_name github_username remote_url

  # Verifica se um nome de repositório foi fornecido
  if [ -z "$1" ]; then
    echo "Erro: Forneça o nome do repositório como argumento." >&2
    echo "Uso: remoteadd <nome-do-repositorio>" >&2
    return 1
  fi
  repo_name="$1"
  github_username="wmogh" # <-- CONFIRME/AJUSTE SE NECESSÁRIO

  # Verifica se a variável de token GH foi carregada do .env
  if [ -z "$GH" ]; then
    echo "Erro: Variável GH (token do GitHub) não está definida." >&2
    echo "Certifique-se que GH=ghp_... existe em ~/.env e foi carregado." >&2
    return 1
  fi

  # Monta a URL do remote com o token
  remote_url="https://${GH}@github.com/${github_username}/${repo_name}.git"

  # Exibe uma mensagem (sem o token!) e executa o comando git
  echo "Executando: git remote add origin 'https://<SEU_TOKEN>@github.com/${github_username}/${repo_name}.git'"
  git remote add origin "$remote_url"

  # Verifica se o comando git falhou
  if [ $? -ne 0 ]; then
    echo "Atenção: O comando 'git remote add' falhou." >&2
    echo "Verifique se o remote 'origin' já existe neste repositório." >&2
    return 1
  fi

  echo "Remote 'origin' adicionado com sucesso para ${repo_name}."
}

# Função para adicionar remote pessoal (notebook)
remoteadd_personal() {
  local repo_name personal_username remote_url

  # Verifica se um nome de repositório foi fornecido
  if [ -z "$1" ]; then
    echo "Erro: Forneça o nome do repositório como argumento." >&2
    echo "Uso: remoteadd_personal <nome-do-repositorio>" >&2
    return 1
  fi
  repo_name="$1"
  personal_username="joaopelegrino"

  # Verifica se a variável de token GH foi carregada do .env
  if [ -z "$GH" ]; then
    echo "Erro: Variável GH (token do GitHub) não está definida." >&2
    echo "Certifique-se que GH=ghp_... existe em ~/.env e foi carregado." >&2
    return 1
  fi

  # Monta a URL do remote pessoal com o token
  remote_url="https://${GH}@github.com/${personal_username}/${repo_name}.git"

  # Exibe uma mensagem (sem o token!) e executa o comando git
  echo "Executando: git remote add personal 'https://<SEU_TOKEN>@github.com/${personal_username}/${repo_name}.git'"
  git remote add personal "$remote_url"

  # Verifica se o comando git falhou
  if [ $? -ne 0 ]; then
    echo "Atenção: O comando 'git remote add' falhou." >&2
    echo "Verifique se o remote 'personal' já existe neste repositório." >&2
    return 1
  fi

  echo "Remote 'personal' adicionado com sucesso para ${personal_username}/${repo_name}."
}

# Função para sincronizar com ambos os remotes (wmogh + notebook)
sync_repos() {
  local branch=$(git branch --show-current 2>/dev/null)
  local message="$1"
  
  if [ -z "$branch" ]; then
    echo "Erro: Não estamos em um repositório Git ou branch não encontrada." >&2
    return 1
  fi

  if [ -z "$message" ]; then
    message="🔄 Sincronização automática - $(date '+%Y-%m-%d %H:%M:%S')"
  fi

  echo "🔄 Sincronizando branch '$branch'..."
  
  # Push para wmogh (origin)
  echo "📤 Pushing para wmogh (origin)..."
  if git push origin "$branch"; then
    echo "✅ Push para wmogh concluído"
  else
    echo "❌ Falha no push para wmogh"
    return 1
  fi
  
  # Push para notebook (personal) se existir
  if git remote get-url personal &>/dev/null; then
    echo "📤 Pushing para notebook (personal)..."
    if git push personal "$branch"; then
      echo "✅ Push para notebook concluído"
      echo "🎉 Sincronização completa!"
    else
      echo "❌ Falha no push para notebook"
      return 1
    fi
  else
    echo "⚠️  Remote 'personal' não configurado. Use 'remoteadd_personal <repo-name>' para configurar."
  fi
}
# Função para copiar caminho completo para clipboard
pwdc() {
  local full_path
  
  # Se um argumento foi fornecido, adiciona ao caminho
  if [ -n "$1" ]; then
    # Verifica se o arquivo/diretório existe
    if [ -e "$1" ]; then
      # Se existe, usa o caminho absoluto
      full_path="$(realpath "$1")"
    else
      # Se não existe, apenas concatena com pwd
      full_path="$(pwd)/$1"
    fi
  else
    # Sem argumento, apenas o diretório atual
    full_path="$(pwd)"
  fi
  
  # Copia para clipboard (funciona no WSL)
  echo -n "$full_path" | clip.exe 2>/dev/null || echo -n "$full_path" | xclip -selection clipboard 2>/dev/null
  
  # Imprime o caminho copiado
  echo "📋 Copiado: $full_path"
}

# Função para mostrar caminho atual e tree da pasta
pwdct() {
  local current_path

  # Obtém o caminho atual
  current_path="$(pwd)"

  # Imprime o caminho atual
  echo "📁 $current_path"
  echo

  # Prepara o conteúdo para clipboard
  local clipboard_content tree_output

  # Verifica se o comando tree está disponível
  if command -v tree >/dev/null 2>&1; then
    echo "🌳 Estrutura do diretório:"
    # Usa tree com opções mais compatíveis e sem caracteres Unicode
    tree_output=$(tree -L 2 -a --dirsfirst --charset ascii)
    echo "$tree_output"
  else
    echo "🌳 Estrutura do diretório (usando ls):"
    # Fallback usando ls com formato mais organizado
    tree_output=$(ls -laF --group-directories-first 2>/dev/null || ls -laF)
    echo "$tree_output"
  fi

  # Prepara conteúdo completo para clipboard
  clipboard_content="$current_path"$'\n\n'"$tree_output"

  # Copia para clipboard (funciona no WSL)
  echo -n "$clipboard_content" | clip.exe 2>/dev/null || echo -n "$clipboard_content" | xclip -selection clipboard 2>/dev/null

  echo
  echo "📋 Conteúdo copiado para clipboard!"
}

# --- Fim Funções ---

# --- Configuração Variáveis Github ---
ORGANIZATION_NAME="wmogh"
# Nome da organização ou usuário do GitHub
REPO_NAME="saas-saude"
SCRIPT_NAME="estruturaissue.sh" # Nome do script que você forneceu
# --- Powerlevel10k ---
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Carrega a configuração do P10k (deve vir por último ou quase último)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# --- Fim Powerlevel10k ---

# --- PATH Configuration ---
# Organizando PATH de forma limpa e sem duplicações
# Adicionar apenas se ainda não estiver no PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
[[ ":$PATH:" != *":$HOME/.npm-global/bin:"* ]] && export PATH="$HOME/.npm-global/bin:$PATH"

# --- Aliases ---


# Shell reload - Recarregar todas as configurações
alias reload="source ~/.zshenv && source ~/.zshrc && source ~/.p10k.zsh && source ~/.fzf.zsh"

# Atalhos para projetos e configurações
alias zed="vim /home/notebook/config/zshrc"
alias ved="vim /home/notebook/config/vimrc"
alias wted="vim '/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json'"

# LLM template aliases
alias llm-new='~/config/create-llm-template.sh'
alias llm-main='vim /home/notebook/workspace/blog/.claude/commands/LLM-main.md'
alias llm-copy='cp /home/notebook/workspace/blog/.claude/commands/LLM-main.md'

# ========================================
# Yazi File Manager Integration
# ========================================

# Function to integrate yazi with shell (change directory on exit)
function yy() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# opencode
export PATH=/home/notebook/.opencode/bin:$PATH

# ========================================
# Obsidian Configuration
# ========================================
export OBSIDIAN_HOME=~/Documents/Obsidian
export OBSIDIAN_BIN=~/Applications/Obsidian-1.7.7.AppImage

# Obsidian aliases
alias obs='nohup $OBSIDIAN_BIN --no-sandbox > /dev/null 2>&1 &'  # Abre Obsidian em background
alias obsidian='nohup $OBSIDIAN_BIN --no-sandbox > /dev/null 2>&1 &'  # Alias completo
alias obs-vault='nohup $OBSIDIAN_BIN --no-sandbox $OBSIDIAN_HOME > /dev/null 2>&1 &'  # Abre diretório padrão
alias obs-kill='pkill -f Obsidian'  # Fecha todos os processos do Obsidian
alias obs-status='ps aux | grep -i obsidian | grep -v grep'  # Verifica status do Obsidian
export PATH="$HOME/.local/bin:$PATH"

# === Aliases de Produtividade ===
# Docker aliases
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"

# Git aliases adicionais
alias gst="git status -sb"
alias gco="git checkout"
alias gcm="git commit -m"
alias glog="git log --oneline --graph --decorate"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"

# Função para estado geral do repositório git (não-interativo)
gitoverview() {
  echo '📊 Estado Geral do Repositório Git'
  echo '════════════════════════════════════'
  echo
  
  echo '📁 Branch atual:'
  git branch --show-current 2>/dev/null
  echo
  
  echo '🌐 Remotes configurados:'
  git remote -v 2>/dev/null
  echo
  
  echo '🌿 Todas as branches (locais e remotas):'
  git --no-pager branch -a --sort=-committerdate 2>/dev/null
  echo
  
  echo '📋 Status do repositório:'
  git status -sb 2>/dev/null
  echo
  
  echo '📈 Últimos 5 commits:'
  git --no-pager log --oneline -5 2>/dev/null
  echo
  
  echo '🔄 Comparação com remote (se disponível):'
  local comparison
  comparison=$(git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null)
  if [ $? -eq 0 ] && [ -n "$comparison" ]; then
    echo "$comparison" | awk '{
      if($1>0) print "↑ " $1 " commits para push"
      if($2>0) print "↓ " $2 " commits para pull"
      if($1==0 && $2==0) print "✅ Branch sincronizada com remote"
    }'
  else
    echo 'Branch não está tracking um remote'
  fi
}

# Navegação rápida
alias conf="cd ~/config"
alias desktop="cd /mnt/c/Users/valor/Desktop"

# Desenvolvimento
alias ports="netstat -tulanp"

# ========================================
# Gerador de Aliases de Edição
# ========================================

# Função para gerar aliases de edição personalizados
# Uso: mkalias [nome_completo_alias] [caminho_absoluto]
# Exemplo: mkalias gited /home/notebook/config/gitconfig
# Exemplo: mkalias nvimed ~/.config/nvim/init.vim
# Resultado: alias gited="vim /home/notebook/config/gitconfig"
mkalias() {
  local alias_name full_path
  
  # Verifica se ambos os argumentos foram fornecidos
  if [ $# -ne 2 ]; then
    echo "❌ Uso: mkalias <nome_alias> <caminho_absoluto>" >&2
    echo "📝 Exemplo: mkalias gited /home/notebook/config/gitconfig" >&2
    echo "📝 Exemplo: mkalias nvimed ~/.config/nvim/init.vim" >&2
    echo "📄 Resultado: alias criado para editar o arquivo" >&2
    return 1
  fi
  
  alias_name="$1"
  full_path="$2"
  
  # Verifica se o arquivo existe
  if [ ! -f "$full_path" ]; then
    echo "⚠️  Arquivo não encontrado: $full_path" >&2
    echo "🤔 Deseja criar o alias mesmo assim? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
      echo "❌ Operação cancelada."
      return 1
    fi
  fi
  
  # Cria o alias temporariamente na sessão atual
  alias "$alias_name"="vim '$full_path'"
  
  # Adiciona permanentemente ao zshrc
  echo "alias $alias_name=\"vim '$full_path'\"" >> /home/notebook/config/zshrc
  
  # Feedback para o usuário
  echo "✅ Alias criado com sucesso!"
  echo "📋 Comando: alias $alias_name=\"vim '$full_path'\""
  echo "🔄 Execute 'reload' para aplicar em novas sessões, ou use já na sessão atual."
  echo "📍 Adicionado ao final do arquivo zshrc"
}

alias cced="vim '/home/notebook/workspace/especialistas/claude-code/acao-cc.md'"
alias arch="vim '/home/notebook/workspace/especialistas/fundamentos/guias-passo-a-passo/arch-minimal-setup.md'"

alias concat-md="PROJETO=\$(basename \"\$PWD\" | tr \"a-z-\" \"A-Z_\"); { echo \"# 📚 \$PROJETO - DOCUMENTAÇÃO COMPLETA\"; echo \"**Gerado em:** \$(date)\"; echo \"\"; find . -name \"*.md\" -type f | sort | while read file; do echo -e \"\n---\n## 📁 \$file\n\"; cat \"\$file\"; done; } > \"\${PROJETO}_COMPLETO.md\" && echo \"✅ Gerado: \${PROJETO}_COMPLETO.md\""

alias concat-parcial='concat_parcial_files() {
  if [ $# -eq 0 ]; then
    echo "❌ Uso: concat-parcial <arquivo1.md> <arquivo2.md> [...]"
    echo "   Exemplo: concat-parcial README.md INSTALL.md CONFIG.md"
    return 1
  fi
  
  PROJETO=$(basename "$PWD" | tr "a-z-" "A-Z_")
  OUTPUT_FILE="${PROJETO}_ARQUIVOS_IMPORTANTES.md"
  
  {
    echo "# 📚 $PROJETO - ARQUIVOS IMPORTANTES"
    echo "**Gerado em:** $(date)"
    echo "**Arquivos incluídos:** $*"
    echo ""
    
    for file in "$@"; do
      if [ -f "$file" ]; then
        echo -e "\n---\n## 📁 $file\n"
        cat "$file"
      else
        echo -e "\n---\n## ❌ $file (não encontrado)\n"
      fi
    done
  } > "$OUTPUT_FILE"
  
  echo "✅ Gerado: $OUTPUT_FILE"
}; concat_parcial_files'

alias vnotas="vim '/home/notebook/workspace/especialistas/aplicando/notas11-09.md'"
alias ned="vim '/home/notebook/workspace/especialistas/desenvovlimento/notas/notas-12-09.md'"
alias sessao='script -c "zsh -c \"PROMPT=\\\"$ \\\" exec zsh\"" ~/logs/sessoes/sessao-$(date +%Y%m%d_%H%M%S)-essencial.txt'


# ========================================
# Claude Code Aliases
# ========================================
alias claude="/home/notebook/.claude/local/claude"

# Claude com permissões bypassed (para ambientes sandbox/desenvolvimento)
alias cs="claude --dangerously-skip-permissions"

# Claude resume - retomar conversas existentes
alias cr="claude --dangerously-skip-permissions --resume"

alias pwds="pwdct_simple"

# Warp Terminal Configuration - Added seg 15 set 2025 07:18:25 -03
# Previne conflitos de notebook creation no Warp
export WARP_CONFIG_DIR="$HOME/.warp"
[ -f "$HOME/.warp/startup.sh" ] && source "$HOME/.warp/startup.sh"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# ========================================
# ERLANG/OTP COMPILATION OPTIONS
# ========================================
export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl"

# ========================================
# ELIXIR/OTP ENVIRONMENT (Healthcare Stack)
# ========================================
# Unicode support para filenames (ex: café.ex)
export ELIXIR_ERL_OPTIONS="+fnu"

# Habilita histórico persistente no IEx
export ERL_AFLAGS="-kernel shell_history enabled"

# Define ambiente padrão do Mix (dev/test/prod)
export MIX_ENV=dev

# Aumenta limite de file descriptors para Phoenix/LiveView
# WSL2 já tem limite alto (1M), mas garantimos o mínimo recomendado
ulimit -n 65536 2>/dev/null || true

# ========================================
# C-ELIXIR-WASM STACK CONFIGURATION
# ========================================
# Emscripten (C/C++ → WASM compiler)
export EMSDK_QUIET=1  # Suprimir mensagens automáticas
source ~/emsdk/emsdk_env.sh

# WASI SDK (C → WASI compiler)
export WASI_SDK_PATH=/opt/wasi-sdk
export PATH="$WASI_SDK_PATH/bin:$PATH"

# Alias para validação da stack C-Elixir-WASM
alias check-wasm='cd ~/workspace/ambiente-iniciar && bash scripts/validate_stack_c_elixir_wasm.sh'
alias validate-stack='check-wasm'  # Alias alternativo

# ========================================
# Gemini CLI Configuration
# ========================================

# Alias básico - sempre usa a versão mais recente disponível no npm
alias gemini='npx @google/gemini-cli@latest'

# Alias para versão específica (stable)
alias gemini-stable='npx @google/gemini-cli@0.8.1'

# Alias para versão preview (mais recente com recursos experimentais)
alias gemini-preview='npx @google/gemini-cli@0.9.0-preview.0'

# Alias para versão nightly (bleeding edge - pode ser instável)
alias gemini-nightly='npx @google/gemini-cli@nightly'

# Função avançada: gerencia versões e exibe informações
gemini-info() {
  echo "📦 Informações do Gemini CLI"
  echo "════════════════════════════════════"
  echo
  echo "📌 Versão instalada globalmente:"
  npm list -g @google/gemini-cli 2>/dev/null | grep @google/gemini-cli || echo "  Nenhuma versão global instalada"
  echo
  echo "🌐 Última versão estável disponível:"
  npm view @google/gemini-cli version 2>/dev/null || echo "  Erro ao consultar npm"
  echo
  echo "🔮 Última versão preview disponível:"
  npm view @google/gemini-cli@preview version 2>/dev/null || echo "  Nenhuma preview disponível"
  echo
  echo "🚀 Aliases disponíveis:"
  echo "  gemini          → npx @google/gemini-cli@latest (sempre atualizado)"
  echo "  gemini-stable   → npx @google/gemini-cli@0.8.1"
  echo "  gemini-preview  → npx @google/gemini-cli@0.9.0-preview.0"
  echo "  gemini-nightly  → npx @google/gemini-cli@nightly"
  echo
  echo "💡 Comandos úteis:"
  echo "  gemini-update   → Atualiza instalação global"
  echo "  gemini-clean    → Remove cache e reinstala"
}

# Função para atualizar instalação global (se existir)
gemini-update() {
  echo "🔄 Atualizando Gemini CLI..."
  if npm list -g @google/gemini-cli &>/dev/null; then
    npm update -g @google/gemini-cli
    echo "✅ Atualização concluída!"
  else
    echo "ℹ️  Nenhuma instalação global encontrada."
    echo "💡 Use 'npm install -g @google/gemini-cli@latest' para instalar globalmente"
  fi
}

# Função para limpar cache e reinstalar
gemini-clean() {
  echo "🧹 Limpando instalação do Gemini CLI..."
  npm uninstall -g @google/gemini-cli 2>/dev/null
  npm cache clean --force
  echo "📦 Reinstalando versão mais recente..."
  npm install -g @google/gemini-cli@latest
  echo "✅ Limpeza e reinstalação concluídas!"
}

# Função para comparar versões disponíveis
gemini-versions() {
  echo "📋 Versões disponíveis do Gemini CLI"
  echo "════════════════════════════════════"
  echo
  echo "🏷️  Versões estáveis recentes:"
  npm view @google/gemini-cli versions --json | grep -v nightly | tail -10
  echo
  echo "🔮 Versões preview recentes:"
  npm view @google/gemini-cli versions --json | grep preview | tail -5
}
