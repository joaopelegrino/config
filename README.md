# 📚 Manual Completo do Ambiente de Desenvolvimento

**Última atualização:** 21/09/2025
**Sistema:** Windows 11 + WSL2 Ubuntu 24.04.3 LTS + VSCode + Warp Terminal + Zsh
**Usuário:** notebook  
**Diretório Base:** `/home/notebook/workspace`  
**Configuração Central:** `/home/notebook/config/`

---

## 📊 Status Geral do Ambiente

### ✅ Componentes Principais Configurados

| Componente | Status | Versão/Detalhes |
|------------|--------|-----------------|
|| **Sistema Operacional** | ✅ | WSL2 Ubuntu 24.04.3 LTS (Kernel 6.6.87.2) |
|| **Shell** | ✅ | Zsh 5.9 com Oh My Zsh + Powerlevel10k |
|| **Terminal Principal** | ✅ | Warp Terminal (WSL2 integrado) + Claude Code v1.0.113 |
|| **Editor Principal** | ✅ | Vim 9.1 (580+ linhas config, 17 plugins + MuComplete) |
|| **Sistema de Completion** | 🆕 | MuComplete + LSP + Completion Nativo Integrado |
|| **VSCode** | ✅ | Com tasks automáticos e workspace configurado |
|| **Git** | ✅ | 2.43.0 com aliases e funções helper |
|| **Python** | ✅ | 3.12.3 |
|| **Node.js** | ✅ | v20.19.4 (atualizada) |
|| **Docker** | ✅ | Docker Desktop v28.4.0 com integração WSL2 ativa |
|| **Gerenciador de Arquivos** | ✅ | Yazi 25.5.31 (Rust-based) |

---

## 🎯 Guia de Início Rápido

### Comandos Essenciais do Dia a Dia

```bash
# Navegação rápida
y           # Abrir Yazi (gerenciador de arquivos)
yy          # Yazi com cd integrado
app-controle # Ir para projeto app-controle
zed         # Editar zshrc
ved         # Editar vimrc

# Git helpers
remoteadd <repo>          # Adicionar remote com token
remoteadd_personal <repo> # Adicionar remote pessoal
sync_repos                # Push para múltiplos remotes

# Diagnóstico
vim-diag    # Diagnóstico completo do Vim
claude doctor # Diagnóstico do Claude Code
ls ~/.warp/ # Verificar configuração Warp (notebooks)
docker ps   # Verificar containers Docker ativos
reload      # Recarregar configurações do shell
```

---

## 🛠️ Vim - Editor Principal

### 📊 Estatísticas da Configuração

- **615+ linhas** de configuração otimizada (+3% desde última atualização)
- **17 plugins** + **MuComplete** (18 plugins total)
- **Sistema de Completion Profissional** implementado
- **LSP** integrado para C, Python, TypeScript
- **🆕 Terminal Integrado** com modo only e navegação completa
- **🆕 Tab-First Workflow** - todos os arquivos abrem em novas abas por padrão
- **🆕 Folding Aberto** - código sempre expandido por padrão
- **🆕 Comando :Vimrc** para edição rápida de configurações
- **Configuração C Nativa Completa** com completion + linting + quickfix
- **Git integration** completa com vim-fugitive
- **FZF** para busca fuzzy ultrarrápida
- **MuComplete** com chains por linguagem
- **Clipboard WSL-Windows** totalmente funcional com fallback
- **Quickfix Navigation** para workflow profissional
- **GCC Integration** nativo para desenvolvimento C

### ⚡ Atalhos Principais

#### 🔍 Navegação e Busca (FZF)
```vim
Ctrl+P          " Buscar arquivos no projeto
Ctrl+B          " Lista de buffers abertos
Ctrl+F          " Busca texto com ripgrep
,h              " Histórico de arquivos
,:              " Histórico de comandos
,/              " Histórico de buscas
```

#### 💾 Comandos Rápidos (Leader = vírgula)
```vim
,w              " Salvar arquivo
,q              " Sair
,x              " Salvar e sair
,<space>        " Limpar highlight de busca
,s              " Toggle spell check
,n              " Toggle números de linha

" 🆕 Terminal Integrado (NOVO)
,t              " Abrir terminal em modo only (tela cheia)
<Esc><Esc>      " Sair do modo terminal
,q              " Fechar terminal (no modo terminal)

" 🆕 Configurações Rápidas (NOVO)
,ev             " Editar vimrc em nova aba
,rv             " Recarregar vimrc
:Vimrc          " Comando personalizado para abrir vimrc
```

#### 🔄 Git Integration (Fugitive)
```vim
,gs             " Git status interativo
,ga             " Git add .
,gc             " Git commit
,gp             " Git push
,gl             " Git log --oneline
,gd             " Git diff split
```

#### 🧠 LSP (Language Server Protocol)
```vim
gd              " Ir para definição
gr              " Listar referências
K               " Mostrar documentação
,rn             " Renomear símbolo
[g / ]g         " Navegar entre erros
```

#### 🚀 Sistema de Completion Profissional (NOVO)
```vim
" Completion Nativo
Ctrl+x Ctrl+l   " Completion de linha inteira
Ctrl+x Ctrl+f   " Completion de caminhos de arquivo
Ctrl+x Ctrl+s   " Completion ortográfico (spell)
Ctrl+x Ctrl+o   " Omni completion (inteligente por linguagem)
Ctrl+x Ctrl+v   " Completion de comandos Vim
Ctrl+x Ctrl+k   " Completion de dicionário
Ctrl+x Ctrl+t   " Completion de thesaurus

" MuComplete - Auto-completion
Tab             " Próxima sugestão (integrado com vsnip)
Shift+Tab       " Sugestão anterior
Ctrl+n/p        " Navegar menu de completion
Enter/→         " Aceitar sugestão
←               " Cancelar completion
```

#### 📝 Chains de Completion por Linguagem
- **HTML/CSS**: Omni → Keywords → Dictionary
- **JavaScript/TypeScript**: Omni → Keywords → Dictionary
- **Python**: Omni → Keywords → Dictionary
- **🆕 C/C++**: Omni → Keywords (ccomplete#Complete integration)
- **Markdown**: Dictionary → Spell → Keywords
- **Vim Scripts**: Commands → Keywords

#### 🆕 Tab-First Workflow (NOVO)
```vim
" Abertura de arquivos sempre em novas abas
:e arquivo.txt        " → Abre em nova aba (automaticamente)
:edit main.py         " → Abre em nova aba (automaticamente)
:E header.h           " → Comando personalizado para nova aba
:Edit script.sh       " → Comando personalizado para nova aba

" Configurações ativas:
set switchbuf=newtab  " Quickfix e help abrem em abas
set showtabline=2     " Sempre mostrar linha de abas
set tabpagemax=50     " Máximo 50 abas
```

#### 🆕 Folding Otimizado (NOVO)
```vim
" Código sempre expandido por padrão
set foldlevelstart=99  " Inicia com tudo aberto
set foldlevel=99      " Mantém tudo aberto

" Comandos de folding quando necessário:
za    " Toggle dobra no cursor
zM    " Fechar todas as dobras (visão estrutural)
zR    " Reabrir todas as dobras (volta ao padrão)
```

#### 🆕 Quickfix & C Development
```vim
" Quickfix Navigation
,qo             " Abrir quickfix window
,qc             " Fechar quickfix window
,qn             " Próximo erro/warning
,qp             " Erro/warning anterior

" C Development Shortcuts
,cb             " Build projeto C (make)
,cm             " Lint com GCC + quickfix automático (C Make)
,cr             " Run programa compilado
```

### 📁 Estrutura de Arquivos Vim

```bash
~/.vim/
├── autoload/
│   └── plug.vim           # Plugin manager
├── plugged/               # 18 plugins instalados (com MuComplete)
│   ├── fzf/              
│   ├── vim-airline/      
│   ├── vim-lsp/          
│   ├── vim-fugitive/     
│   ├── vim-mucomplete/   # 🆕 Sistema de auto-completion
│   └── ...               
├── undodir/              # Histórico persistente
├── spell/                # Dicionários PT-BR/EN
└── vsnip/                # Snippets customizados

/home/notebook/config/
├── vimrc                 # Config principal (580+ linhas, sistema completo)
├── vim-diagnostic.sh     # Script de diagnóstico
└── sync-vim-config.sh    # Script de sincronização
```

---

## 🐚 Shell - Zsh com Oh My Zsh

### Configuração do Zsh

#### Arquivos de Configuração
- `~/.zshenv` - Variáveis de ambiente (carregado sempre)
- `~/.zshrc` - Configuração interativa principal
- `~/.p10k.zsh` - Tema Powerlevel10k
- `~/.fzf.zsh` - Configuração FZF

#### Plugins Ativos
```bash
plugins=(
    git                     # Aliases git
    zsh-autosuggestions    # Sugestões automáticas
    z                      # Navegação rápida
    zsh-syntax-highlighting # Syntax highlighting
    zsh-autocomplete       # Autocompletion avançado
)
```

### Funções Customizadas

#### Git Remote com Token
```bash
# Adicionar remote com token do ~/.env
remoteadd <nome-repo>

# Adicionar remote pessoal
remoteadd_personal <nome-repo>

# Sincronizar com múltiplos remotes
sync_repos [mensagem-commit]
```

#### Yazi Integration
```bash
# Função yy() - abre Yazi e muda diretório ao sair
 yy [caminho]

# Aliases
y   # Abrir Yazi
b   # Abrir Yazi (alternativo)
fm  # File manager
```

### Variáveis de Ambiente Importantes

```bash
# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"

# FZF Configuration
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'

# Workspace
export WORKSPACE="$HOME/workspace"

# Configurações locais (não versionadas)
source ~/.env  # Contém tokens e segredos
```

---

## 🤖 Claude Code - AI Terminal Assistant

### 📊 Status da Configuração (Atualizado: 15/09/2025)

| Componente | Status | Detalhes |
|------------|--------|---------|
| **Versão Atual** | ✅ | 1.0.113 (Claude Code) |
| **Instalação** | ✅ | Local (npm-local) sem conflitos |
| **Auto-updates** | ✅ | Habilitado e funcionando |
| **Método de instalação** | ✅ | npm-local (otimizado) |
| **Localização** | ✅ | `/home/notebook/.claude/local/` |

### 🛠️ Resolução de Conflito de Instalações (15/09/2025)

#### 🔴 Problema Identificado
- **Conflito**: Duas instalações simultâneas (global vs local)
- **Instalação Global**: v1.0.92 (antiga, sendo usada incorretamente)
- **Instalação Local**: v1.0.113 (mais recente, não estava sendo usada)
- **Auto-update falhando**: Conflito entre métodos de instalação

#### 🔧 Solução Aplicada
```bash
# 1. Removido link simbólico da instalação global
rm /usr/local/bin/claude

# 2. Criado novo link para instalação local
ln -s /home/notebook/.claude/local/claude /usr/local/bin/claude

# 3. Removidos diretórios residuais da instalação global
rm -rf /usr/lib/node_modules/@anthropic-ai/claude-code
rm -rf /usr/lib/node_modules/@anthropic-ai/.claude-code-*
```

#### ✅ Resultado Final
- **Antes**: v1.0.92 (global) com conflitos
- **Depois**: v1.0.113 (local) sem conflitos
- **Auto-updates**: Funcionando corretamente
- **Status**: Sistema totalmente otimizado

### 🔍 Comandos de Diagnóstico

```bash
# Verificar versão atual
claude --version
# Output esperado: 1.0.113 (Claude Code)

# Diagnóstico completo
claude doctor
# Output esperado: npm-local (1.0.113), sem warnings

# Verificar localização do executável
which claude
# Output esperado: /usr/local/bin/claude

# Verificar link simbólico
ls -la /usr/local/bin/claude
# Output esperado: link para /home/notebook/.claude/local/claude
```

### 📝 Configuração Atual

#### Estrutura de Arquivos
```bash
/home/notebook/.claude/local/
├── claude                  # Executável principal
├── node_modules/           # Dependências npm
├── package.json            # Dependência: @anthropic-ai/claude-code ^1.0.113
└── package-lock.json       # Lock de versões

/usr/local/bin/
└── claude -> /home/notebook/.claude/local/claude  # Link simbólico
```

#### Configurações Ativas
- **Método de instalação**: local (recomendado)
- **Auto-updates**: habilitado por padrão
- **Caminho de execução**: `/home/notebook/.claude/local/node_modules/.bin/claude`
- **Permissões de atualização**: Sim
- **Integração**: Warp Terminal + WSL2

### 🚑 Troubleshooting

#### Problema: "Auto-update failed"
**Solução:**
```bash
# 1. Executar diagnóstico
claude doctor

# 2. Se houver conflito de instalações
claude migrate-installer

# 3. Atualizar manualmente se necessário
cd ~/.claude/local && npm update @anthropic-ai/claude-code
```

#### Problema: "Command not found: claude"
**Solução:**
```bash
# Verificar se link simbólico existe
ls -la /usr/local/bin/claude

# Recriar link se necessário
ln -s /home/notebook/.claude/local/claude /usr/local/bin/claude
```

#### Problema: "Multiple installations found"
**Solução:**
```bash
# Remover instalação global (se existir)
npm uninstall -g --force @anthropic-ai/claude-code

# Usar migração automática
claude migrate-installer
```

### 📈 Manutenção Recomendada

#### Semanal
```bash
# Verificar status
claude doctor

# Verificar atualizações disponíveis
cd ~/.claude/local
npm outdated
```

#### Mensal
```bash
# Forçar atualização se necessário
cd ~/.claude/local
npm update @anthropic-ai/claude-code

# Limpeza de cache
npm cache clean --force
```

### 📊 Histórico de Versões

| Data | Versão | Status | Observações |
|------|--------|--------|-------------|
| 15/09/2025 | 1.0.113 | ✅ Ativo | Instalação local otimizada, conflitos resolvidos |
| Anterior | 1.0.92 | ❌ Removida | Instalação global com conflitos |

---

## 🚀 Warp Terminal - Terminal AI Moderno

### 📊 Status da Configuração (15/09/2025)

| Componente | Status | Detalhes |
|------------|--------|---------|
| **Terminal Ativo** | ✅ | Warp Terminal detectado via $TERM_PROGRAM |
| **Integração WSL2** | ✅ | Funcionando com Ubuntu 24.04.3 LTS |
| **Shell Padrão** | ✅ | Zsh 5.9 com configurações personalizadas |
| **Variáveis de Ambiente** | ✅ | WARP_* configuradas corretamente |
| **Claude Code Integration** | ✅ | v1.0.113 funcionando perfeitamente |

### 🛠️ Configuração Detectada

#### Variáveis de Ambiente Warp Ativas
```bash
TERM_PROGRAM=WarpTerminal
WARP_HONOR_PS1=0
WARP_USE_SSH_WRAPPER=1
WARP_SHELL_DEBUG_MODE=0
WARP_IS_LOCAL_SHELL_SESSION=1
```

#### Integração WSL2
- **Tipo de Sessão**: Local Shell Session (WSL2)
- **Terminal Type**: xterm-256color
- **SSH Wrapper**: Habilitado
- **PS1 Honor**: Desabilitado (usando Powerlevel10k)

### ⌨️ Atalhos Essenciais do Warp (WSL)

#### Gerenciamento de Abas (Tabs)
| Funcionalidade | Atalho | Descrição |
|----------------|--------|-----------|
| **Nova Aba** | `CTRL+SHIFT+T` | Cria nova aba no terminal |
| **Fechar Aba** | `CTRL+SHIFT+W` | Fecha aba ativa |
| **Reabrir Aba** | `CTRL+ALT+T` | Restaura aba fechada (60s) |
| **Navegar Abas** | `CTRL+1` a `CTRL+9` | Ir direto para aba específica |
| **Renomear Aba** | Duplo clique | Editar nome da aba |

#### Gerenciamento de Painéis (Panes)
| Funcionalidade | Atalho | Descrição |
|----------------|--------|-----------|
| **Dividir à Direita** | `CTRL+SHIFT+D` | Novo painel à direita |
| **Dividir para Baixo** | `CTRL+SHIFT+E` | Novo painel abaixo |
| **Navegar Painéis** | `CTRL+ALT+Setas` | Alternar entre painéis |
| **Maximizar Painel** | `CTRL+SHIFT+ENTER` | Expandir painel atual |
| **Fechar Painel** | `CTRL+SHIFT+W` | Fechar painel ativo |

#### Funcionalidades Avançadas
| Funcionalidade | Atalho | Descrição |
|----------------|--------|-----------|
| **Command Palette** | `CTRL+SHIFT+P` | Comandos rápidos do Warp |
| **Configurações** | `CTRL+,` | Abrir configurações |
| **Session Navigation** | `SHIFT+CTRL+P` | Alternar entre sessões |

### 🔗 Integração com Ferramentas

#### WSL + Zsh + Vim + Yazi
```bash
# Configurar shell padrão para WSL
# Settings > Features > Session > Startup shell for new sessions
# Garantir que novas abas/painéis usem WSL

# Workflow recomendado:
# Aba 1: Workspace geral (~/workspace)
# Aba 2: Projeto ativo (Vim)
# Aba 3: Yazi para navegação
# Aba 4: Claude Code para assistência
```

#### Produtividade com Múltiplas Abas
```bash
# Exemplo de workflow no Warp:
CTRL+SHIFT+T          # Nova aba
cd ~/workspace/blog   # Navegar para projeto
vim post.md           # Editar conteúdo

CTRL+SHIFT+T          # Nova aba
yazi ~/workspace      # Gerenciador de arquivos

CTRL+SHIFT+T          # Nova aba
claude doctor         # Verificar sistema
```

### 📝 Workflows Personalizados

Pode criar workflows em `~/.warp/workflows/` para automatizar tarefas:

```yaml
# ~/.warp/workflows/dev-workspace.yml
name: "Development Workspace"
commands:
  - "cd ~/workspace && clear"
  - "cd ~/workspace/blog && ls -la"
  - "cd ~/config && vim zshrc"
  - "cd ~/workspace && git status"
```

### ⚠️ Compatibilidade e Limitações

#### ✅ Funciona Perfeitamente
- Zsh com Oh My Zsh e Powerlevel10k
- Claude Code (AI terminal assistant)
- Git workflows e comandos
- Navegação com Vim
- Scripts bash/zsh personalizados

#### 🗒 Nota sobre Yazi
- Yazi tem algumas incompatibilidades menores com Warp
- **Solução**: Funciona bem, mas para debugs use `Ctrl+C`
- Alternativa: usar Windows Terminal especificamente para Yazi

### 📊 Performance

```bash
# Métricas do ambiente atual:
Memória Total: 5.8GB (5.2GB disponível)
Swap: 2.0GB
Kernel WSL2: 6.6.87.2-microsoft-standard
Zsh Performance: < 500ms startup
```

### 🔧 Troubleshooting

#### Problema: Warp não detecta WSL
**Solução:**
```bash
# Verificar variáveis de ambiente
echo $TERM_PROGRAM  # Deve mostrar: WarpTerminal
echo $WARP_IS_LOCAL_SHELL_SESSION  # Deve ser: 1
```

#### Problema: Configurações Zsh não carregam
**Solução:**
```bash
# Forçar recarga das configurações
source ~/.zshrc
reload  # Alias personalizado
```

#### Problema: Claude Code não funciona
**Solução:**
```bash
# Verificar instalação
claude --version  # Deve mostrar: 1.0.113
claude doctor     # Diagnóstico completo
```

### 🔧 Troubleshooting Aplicado (15/09/2025)

#### 🚨 **Problema Resolvido: "Failed to Create Notebook"**

**Sintoma**: Erro "failed to create notebook" ao abrir Warp Terminal  
**Causa Identificada**: Ausência de configuração Warp + conflitos SSH Agent  
**Soluções Aplicadas**:

```bash
# 1. Estrutura Warp criada
mkdir -p ~/.warp/notebooks
chmod 755 ~/.warp

# 2. Configuração Warp otimizada
cat > ~/.warp/config.json <<EOF
{
  "notebook_creation_enabled": true,
  "workspace_path": "~/.warp/notebooks",
  "settings": {
    "shell_integration": true,
    "wsl_compatibility": true,
    "zsh_support": true
  }
}
EOF

# 3. Script de startup anti-conflitos
cat > ~/.warp/startup.sh <<EOF
export WARP_NOTEBOOK_PATH="$HOME/.warp/notebooks"
export WARP_CONFIG_PATH="$HOME/.warp"
EOF

# 4. Integração com .zshrc
echo '[ -f "$HOME/.warp/startup.sh" ] && source "$HOME/.warp/startup.sh"' >> ~/.zshrc
```

**Resultado**: ✅ **PROBLEMA RESOLVIDO**
- Diretório ~/.warp estruturado
- Configuração otimizada para WSL2
- Notebooks funcionais
- SSH Agent mantido sem conflitos

### 🕰️ Histórico de Uso

| Data | Status | Observações |
|------|--------|-------------|
| 15/09/2025 | ✅ Ativo | Terminal principal, problema "failed to create notebook" **RESOLVIDO** |
| 15/09/2025 | 🔧 Fix | Estrutura ~/.warp criada, conflitos SSH Agent corrigidos |

Desde a migração do Windows Terminal para Warp, o ambiente apresenta:
- **Melhor performance** na navegação entre abas
- **Integração AI nativa** com Claude Code
- **Produtividade aumentada** com workflows automatizados
- **Notebooks funcionais** (problema "failed to create notebook" resolvido)
- **Compatibilidade total** com stack WSL2 + Zsh + Vim

---

## 🐍 Python - Configuração e Ambientes Virtuais

### Status Python
| Componente | Versão | Status | Observações |
|------------|--------|--------|-------------|
| **Python** | 3.12.3 | ✅ | Comando: `python3` |
| **pip** | 24.0 | ✅ | Ambiente gerenciado (PEP 668) |
| **pipx** | 1.7.1 | ✅ | Para ferramentas globais |
| **virtualenv** | 20.34.0 | ✅ | Alternativa ao venv |

### Ambiente "externally-managed" (PEP 668)
O Python moderno protege o ambiente do sistema contra instalações diretas via pip. **Isso é normal e correto.**

#### ✅ Soluções Recomendadas

**1. Ambiente Virtual (Projetos)**
```bash
# Criar ambiente
virtualenv meu_projeto
# ou: python3 -m venv meu_projeto  (se python3-venv estiver instalado)

# Ativar
source meu_projeto/bin/activate

# Instalar pacotes
pip install pandas numpy matplotlib

# Trabalhar normalmente
python script.py

# Desativar
deactivate
```

**2. pipx (Ferramentas Globais)**
```bash
# Adicionar ao PATH (permanente)
export PATH="$HOME/.local/bin:$PATH"

# Instalar aplicações
pipx install marimo
pipx install black
pipx install jupyter

# Usar diretamente
marimo tutorial intro
```

**3. Forçar Instalação (⚠️ Não Recomendado)**
```bash
pip install --break-system-packages pacote
```

### Ambiente Virtual "casa" Configurado
```bash
# Localização
~/workspace/casa/

# Ativar
source casa/bin/activate

# Verificar
which python  # /home/notebook/workspace/casa/casa/bin/python
which pip     # /home/notebook/workspace/casa/casa/bin/pip
```

### Configuração PATH
```bash
# pipx adicionado permanentemente
export PATH="$HOME/.local/bin:$PATH"
```

### Resolução de Problemas Comuns

#### "externally-managed-environment"
- ✅ **Normal**: Proteção do Python sistema
- 🚫 **Não é erro**: É segurança moderna
- ✅ **Solução**: Usar ambiente virtual ou pipx

#### "Command not found: python"
```bash
# Use python3
python3 --version
python3 -m venv meu_env
```

#### "ensurepip not available"
```bash
# Instalar virtualenv como alternativa
python3 -m pip install --user --break-system-packages virtualenv
virtualenv nome_ambiente
```

### Guia Rápido por Caso de Uso

| Caso de Uso | Comando Recomendado |
|-------------|---------------------|
| **Projeto específico** | `virtualenv projeto && source projeto/bin/activate` |
| **Ferramenta global** | `pipx install ferramenta` |
| **Experimento rápido** | `virtualenv temp && source temp/bin/activate` |
| **Jupyter/análise** | `pipx install jupyter` ou ambiente virtual |

---

## 💻 VSCode - Configuração de Workspaces

### Workspaces Disponíveis

```bash
# Principais workspaces
~/workspace/INICIAR.code-workspace      # Workspace padrão
~/workspace/app-controle.code-workspace # Projeto app-controle
~/workspace/bm.code-workspace           # Projeto bm
```

### Extensões Essenciais Instaladas

Com base no contexto externo, para desenvolvimento C + DevOps:

```bash
# Verificar extensões instaladas
code --list-extensions

# Extensões recomendadas:
- ms-vscode.cpptools-extension-pack  # C/C++ completo
- mesonbuild.mesonbuild              # Build system moderno
- yzhang.markdown-all-in-one         # Markdown
- ritwickdey.liveserver              # Preview HTML
- vadimcn.vscode-lldb                # Debugger avançado
- usernamehw.errorlens               # Erros inline
```

### Tasks Automáticas (baseado no contexto)

Localização: `~/workspace/.vscode/tasks.json`

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "🚀 Abrir Terminais Workspace",
      "type": "shell",
      "command": "echo",
      "args": ["Iniciando terminais..."],
      "dependsOn": [
        "Terminal: Workspace Raiz",
        "Terminal: Config"
      ],
      "runOptions": {
        "runOn": "folderOpen"
      }
    }
  ]
}
```

---

## 🐳 Docker - Containerização e DevOps

### Status Docker Desktop
```bash
# Verificar Docker
docker --version
docker-compose --version

# Docker Desktop deve estar rodando no Windows
# Com integração WSL2 ativada
```

### Exemplo de Desenvolvimento Containerizado (do contexto)

#### Dockerfile.dev
```dockerfile
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y \
    gcc build-essential meson ninja-build git \
    libcmark-dev valgrind gdb \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
VOLUME ["/workspace"]
USER dev
CMD ["bash"]
```

#### docker-compose.dev.yml
```yaml
version: '3.8'
services:
  dev:
    build: 
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/workspace
    ports:
      - "8080:8080"
    tty: true
    stdin_open: true
```

---

## 📁 Yazi - Gerenciador de Arquivos

### Comandos Básicos

#### Navegação
- `j/k` - Mover para baixo/cima
- `h/l` - Voltar/entrar em diretório
- `gg/G` - Início/fim da lista

#### Operações
- `y` - Copiar (yank)
- `x` - Recortar
- `p` - Colar
- `d` - Deletar para lixo
- `r` - Renomear
- `a` - Criar arquivo
- `A` - Criar diretório

#### Busca e Filtro
- `/` - Filtrar arquivos (esconde não correspondentes)
- `s` ou `f` - Buscar arquivo (pula para ele)
- `n/N` - Próximo/anterior resultado

#### Atalhos Customizados
- `gw` - Ir para workspace
- `gv` - Ir para config
- `gh` - Ir para home

### ⚠️ Nota sobre Warp Terminal
O Yazi tem incompatibilidades conhecidas com o Warp Terminal. Use Windows Terminal ou VSCode terminal para melhor experiência com Yazi.

---

## 🖥️ Windows Terminal - Configuração Central

### 📍 Localização dos Arquivos de Configuração

#### Path Oficial do Windows Terminal
```
Windows: C:\Users\valor\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
WSL:     /mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

#### Backup Versionado (Este Repositório)
```
Local:   /home/notebook/config/windows-terminal-settings.json
```

### 🔄 Sincronização de Configurações

Para manter as configurações sincronizadas entre o Windows Terminal oficial e o backup versionado:

```bash
# Copiar configuração do Windows Terminal para backup
cp "/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" \
   "/home/notebook/config/windows-terminal-settings.json"

# Aplicar backup para Windows Terminal (cuidado - sobrescreve)
cp "/home/notebook/config/windows-terminal-settings.json" \
   "/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
```

### ⚠️ Configurações Principais Verificadas

- **✅ Perfil Ubuntu WSL** configurado
- **✅ Fonte Nerd Font** (Hack Nerd Font)  
- **✅ Diretório inicial WSL** (`//wsl.localhost/Ubuntu-24.04/home/notebook`)
- **✅ Atalhos personalizados** para produtividade
- **✅ Esquemas de cores** (Dracula, Nord, Ubuntu)

### 🔍 Verificação via Diagnóstico

O script `diagnostico-ambiente.sh` verifica automaticamente:
- Existência do arquivo de configuração
- Configuração do perfil WSL
- Fonte Nerd Font
- Diretório inicial correto

---

## 🔧 Ferramentas de Desenvolvimento

### Build Systems Modernos (2024-2025)

Baseado na pesquisa do contexto externo:

| Ferramenta | Uso Recomendado | Performance |
|------------|-----------------|-------------|
| **Meson + Ninja** | ✅ Projetos novos C/C++ | 100x mais rápido que alternativas |
| **CMake** | Projetos grandes/legados | Padrão da indústria |
| **Make** | ❌ Não recomendado para novos projetos | Lento, sintaxe arcaica |

### Markdown Processing

| Biblioteca | Status | Performance |
|------------|--------|-------------|
| **CMark** | ✅ Padrão atual | 3x mais rápido que Discount |
| **Discount** | Legacy | Ainda usado mas sendo substituído |
| **Hoedown/Sundown** | Descontinuado | Projetos migrando para CMark |

---

## 🚀 Workflows de Produtividade

### Workflow 1: Desenvolvimento de Projeto

```bash
# 1. Abrir workspace no VSCode
code ~/workspace/INICIAR.code-workspace

# 2. Navegação com Yazi
 yy ~/workspace/learning
s                  # Buscar arquivo
Enter              # Abrir localização

# 3. Edição com Vim
vim arquivo.c
Ctrl+P             # Buscar arquivos
,gs                # Git status
,gc                # Git commit

# 4. Build com Meson
meson setup build
ninja -C build

# 5. Container para testes
docker-compose -f docker-compose.dev.yml up
```

### Workflow 2: Manutenção de Configurações

```bash
# 1. Editar configurações
zed                # Editar zshrc
ved                # Editar vimrc

# 2. Testar mudanças
reload             # Recarregar shell
vim-diag           # Diagnosticar Vim

# 3. Backup e versionamento
cd ~/config
git add .
git commit -m "Update configurations"
sync_repos         # Push para múltiplos remotes
```

---

## 📊 Diagnóstico e Troubleshooting

### Comandos de Diagnóstico

```bash
# Sistema geral
uname -a           # Info do sistema
echo $SHELL        # Shell atual
echo $TERM         # Terminal

# Vim
vim-diag           # Diagnóstico completo
vim -c 'PlugStatus' # Status dos plugins
vim -c 'LspStatus'  # Status do LSP

# Git
git remote -v      # Verificar remotes
git status         # Status do repositório

# Docker
docker ps          # Containers rodando
docker-compose ps  # Status do compose
```

### Problemas Comuns e Soluções

#### Vim plugin não funciona
```vim
:PlugStatus        " Verificar status
:PlugUpdate        " Atualizar plugins
:PlugInstall       " Reinstalar
```

#### LSP não funciona
```vim
:LspStatus         " Verificar servidor
:LspInstallServer  " Instalar servidor
```

#### Yazi com problemas no Warp
- Use Windows Terminal ou VSCode terminal
- Ou execute comandos com `Ctrl+C` para sair

#### Docker não encontrado no WSL
1. Abrir Docker Desktop no Windows
2. Settings → Resources → WSL Integration
3. Ativar para sua distro Ubuntu
4. Reiniciar terminal

---

## 📚 Documentação Adicional

### Arquivos de Referência
- `/home/joao/config/vim-README.md` - Documentação completa do Vim
- `/home/joao/config/vim-quick-guide.md` - Guia rápido do Vim
- `/home/joao/workspace/ambiente.md` - Configuração do ambiente
- `/home/joao/workspace/README.md` - Documentação do workspace

### Scripts Úteis
- `/home/joao/config/vim-diagnostic.sh` - Diagnóstico do Vim
- `/home/joao/config/sync-to-windows.sh` - Sincronização com Windows

### Recursos Online
- [VSCode Docs](https://code.visualstudio.com/docs)
- [Vim Documentation](https://vimhelp.org/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Docker WSL2 Integration](https://docs.docker.com/desktop/wsl/)
- [Yazi Documentation](https://yazi-rs.github.io/)

---

## 📊 Estatísticas Detalhadas do Sistema

### Recursos do Sistema (WSL2)
```
Kernel: 6.6.87.2-microsoft-standard-WSL2
Distribuição: Ubuntu 24.04.2 LTS (Noble)
WSL Version: 2.5.9.0
Arquitetura: x86_64
Processador: Intel Core i7-7500U @ 2.70GHz
Memória: 5.8 GB (4.2 GB livre)
Swap: 2.0 GB configurado
Disco: 1007 GB total, 16 GB usado (2% ocupação)
Performance Shell: 478ms (✓ Ótimo)
```

### Ferramentas Instaladas e Versões
| Ferramenta | Versão | Status | Path |
|------------|--------|--------|------|
| Git | 2.43.0 | ✓ | `/usr/bin/git` |
| Node.js | 22.15.0 | ✓ | `/usr/bin/node` |
| NPM | 10.9.2 | ✓ | `/usr/bin/npm` |
| Python | 3.12.3 | ✓ | `/usr/bin/python3` |
| GCC | 13.3.0 | ✓ | `/usr/bin/gcc` |
| Rust | 1.89.0 | ✓ | `~/.cargo/bin/rustc` |
| Cargo | 1.89.0 | ✓ | `~/.cargo/bin/cargo` |
| CMake | 3.28.3 | ✓ | `/usr/bin/cmake` |
| Meson | 1.3.2 | ✓ | `/usr/bin/meson` |
| Ninja | 1.11.1 | ✓ | `/usr/bin/ninja` |
| Docker | 28.3.2 | ✓ | Via Docker Desktop |
| Kubernetes | 1.30.5 | ✓ | Local configurado |

---

## 🎮 Warp Terminal - Guia Completo

### Atalhos Essenciais (WSL)
| Função | Atalho | Descrição |
|---------|--------|-----------|
| Nova Aba | `CTRL+SHIFT+T` | Cria nova aba no terminal |
| Fechar Aba | `CTRL+SHIFT+W` | Fecha aba ativa |
| Reabrir Aba | `CTRL+ALT+T` | Restaura aba fechada (60s) |
| Dividir Painel Direita | `CTRL+SHIFT+D` | Novo painel à direita |
| Dividir Painel Baixo | `CTRL+SHIFT+E` | Novo painel abaixo |
| Navegar Painéis | `CTRL+ALT+Setas` | Alterna entre painéis |
| Maximizar Painel | `CTRL+SHIFT+ENTER` | Expande painel atual |
| Command Palette | `CTRL+SHIFT+P` | Comandos rápidos |
| Configurações | `CTRL+,` | Abre configurações |
| Navegar entre abas | `CTRL+1` até `CTRL+9` | Ir direto para aba |

### Workflows Recomendados para Warp
```yaml
# Criar arquivo: ~/.warp/workflows/dev-workspace.yml
name: "Workspace Development"
commands:
  - "cd ~/workspace && clear"
  - "cd ~/workspace/learning && ls -la"
  - "cd ~/config && vim zshrc"
  - "cd ~/workspace && git status"
```

---

## 📖 Guia Completo do Vim - Funcionalidades Avançadas

### 🎯 Filosofia do Vim e Mindset Produtivo

#### Os 4 Pilares da Produtividade no Vim
1. **Modal Editing**: Separação clara entre navegação (Normal) e edição (Insert)
2. **Composição de Comandos**: Verbos + Números + Movimentos (`d3w` = delete 3 words)
3. **Repetição Inteligente**: Comando `.` repete última ação, macros para tarefas complexas
4. **Fluxo Sem Mouse**: Mãos sempre no teclado, navegação eficiente

### 🔧 Configurações Específicas por Linguagem (NOVO)

#### 🆕 Linguagem C - Configuração Otimizada
**Implementado:** Sistema completo para desenvolvimento C profissional

##### Completion System para C
```vim
" C/C++ Enhanced Completion - Auto-ativado para arquivos .c/.cpp
autocmd FileType c,cpp setlocal omnifunc=ccomplete#Complete
autocmd FileType c,cpp setlocal completefunc=ccomplete#Complete
autocmd FileType c,cpp setlocal path+=.,/usr/include,/usr/local/include

" Atalhos de Completion:
Ctrl+x Ctrl+o   " Omni completion (funções C padrão)
Ctrl+x Ctrl+f   " Completion de includes (#include "header.h")
Ctrl+x Ctrl+i   " Completion de arquivos incluídos
```

##### Sistema de Linting Nativo para C
```vim
" Compilação e lint automático - GCC com warnings otimizados
autocmd FileType c,cpp compiler gcc
autocmd FileType c,cpp setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c99\ -fsyntax-only\ %

" Shortcuts para desenvolvimento C:
,cb             " Compilar projeto (build)
,cm             " Lint com quickfix automático (C Make)
,cr             " Executar programa compilado
```

##### Quickfix Navigation para C
```vim
" Navegação otimizada para errors/warnings
,qo             " Abrir quickfix window
,qc             " Fechar quickfix window
,qn             " Próximo erro/warning
,qp             " Erro/warning anterior
,qf             " Primeiro erro
,ql             " Último erro
```

##### Features Avançadas C
```vim
" Include path inteligente para headers
autocmd FileType c,cpp setlocal include=^\\s*#\\s*include
autocmd FileType c,cpp setlocal define=^\\s*#\\s*define
autocmd FileType c,cpp setlocal suffixesadd+=.h,.c,.cpp,.hpp,.cxx

" Line guide para código C (80 caracteres)
autocmd FileType c,cpp setlocal textwidth=80
autocmd FileType c,cpp setlocal colorcolumn=81
```

##### Workflow C Completo
```bash
# 1. Criar projeto C
vim main.c

# 2. Editar com completion inteligente
# Digite "str" + Ctrl+X Ctrl+O → sugere string.h functions
# Digite "prin" + Ctrl+X Ctrl+O → sugere printf, etc.

# 3. Lint e build
,cm                " Verificar erros/warnings
,qn ,qp           " Navegar entre problemas
,cb               " Build completo

# 4. Testar
,cr               " Executar programa
```

### Técnicas Avançadas de Edição

#### Text Objects - A Gramática do Vim
```vim
# VERBOS
d    - delete
c    - change
y    - yank (copy)
v    - visual select

# TEXT OBJECTS
iw   - inner word
aw   - a word (com espaços)
i"   - inner quotes
a"   - quotes inclusivo
i(   - inner parentheses
a(   - parentheses inclusivo
it   - inner tag (HTML)
at   - a tag (HTML completo)
```

#### Macros - Automação de Tarefas
```vim
qa                  # Iniciar gravação na macro 'a'
0                   # Início da linha
i{"name": "<Esc>    # Inserir início do JSON
$a"},<Esc>          # Adicionar final
j                   # Próxima linha
q                   # Parar gravação

# Executar macro:
 @PRD_LLM_FINANCE_APP.md                  # Executar uma vez
10 @PRD_LLM_FINANCE_APP.md                # Executar 10 vezes
 @@                  # Repetir última macro
```

#### Registers - Clipboard Avançado
```vim
# REGISTERS ESPECIAIS
""   - Default register
"0   - Último yank
"1-9 - Histórico de deletes
"+   - System clipboard
"*   - Selection clipboard
"_   - Black hole (delete sem guardar)
"/   - Última busca
":   - Último comando

# USO PRÁTICO
"ayy                # Yank linha para register 'a'
"ap                 # Paste do register 'a'
"+yy                # Copiar para clipboard do sistema
"_dd                # Deletar sem afetar registers
:registers          # Lista todos os registers
```

### Comandos Personalizados no vimrc
```vim
" Comando para formatar JSON
command! FormatJSON %!python3 -m json.tool

" Comando para remover trailing whitespace
command! CleanWhitespace %s/\s\+$//e

" Comando para inserir timestamp
command! Timestamp put =strftime('%Y-%m-%d %H:%M:%S')
```

---

## 📦 Estrutura Completa do Workspace

```
/home/joao/workspace/
├── 📚 learning/              # Projetos de Aprendizado
│   ├── material_estudo/      # Documentação estruturada
│   │   ├── DD-MM/           # Trabalho diário (ex: 25-07)
│   │   ├── projetos/        # Definições de projetos
│   │   ├── topicos/         # Conhecimento por tema
│   │   └── fornecedores/    # Informações de serviços
│   ├── site_wm/             # Projeto Site WM
│   ├── app-controle/        # Aplicação de controle
│   └── projetos_c/          # Projetos C de aprendizado
├── 🚀 rodando/              # Projetos em Produção
├── 📄 *.code-workspace      # 8 arquivos de workspace VSCode
├── 📋 ambiente.md           # Configuração detalhada do ambiente
└── 📖 README.md             # Documentação geral

/home/joao/config/
├── bashrc                   # Config Bash
├── gitconfig                # Config Git global
├── fzf.zsh                  # Config FZF para Zsh
├── fzf.bash                 # Config FZF para Bash
├── profile                  # Profile shell
├── p10k.zsh                 # Tema Powerlevel10k
├── zshenv                   # Variáveis de ambiente Zsh
├── zshrc                    # Config principal Zsh
├── vimrc                    # Config Vim (547 linhas, vim-gtk3 +clipboard)
├── vimrc.backup             # Backup da config anterior
├── vim-README.md            # Doc completa do Vim
├── vim-quick-guide.md       # Guia rápido Vim
├── vim-diagnostic.sh        # Script diagnóstico
├── sync-to-windows.sh       # Sincronização
└── instrucoes.md            # Este arquivo consolidado
```

### Convenções de Documentação

#### Para Projetos de Aprendizado (`learning/`)
- ✓ Usar método texto sintético com tags PT-BR
- ✓ Documentar sessões de aprendizado detalhadas
- ✓ Incluir checklists incrementais
- ✓ Tags recomendadas:
  ```markdown
  <!-- CONTEXTO:tema:subtema -->
  <!-- BUSCA:conceito_principal -->
  <!-- SECAO:INICIO:nome -->
  <!-- PRIORIDADE:alta -->
  <!-- REF_CRUZADA:tipo:nome -> caminho -->
  ```

#### Para Projetos em Produção (`rodando/`)
- ❌ NÃO usar tags de texto sintético
- ✓ Usar documentação padrão de mercado
- ✓ README.md limpo e profissional
- ✓ Compatível com GitHub/GitLab

---

## ⚙️ Configurações Centralizadas

### Links Simbólicos Ativos
```bash
# Todos apontam para /home/notebook/config/
~/.bashrc     → /home/notebook/config/bashrc
~/.gitconfig  → /home/notebook/config/gitconfig  
~/.fzf.zsh    → /home/notebook/config/fzf.zsh
~/.fzf.bash   → /home/notebook/config/fzf.bash
~/.profile    → /home/notebook/config/profile
~/.p10k.zsh   → /home/notebook/config/p10k.zsh
~/.zshenv     → /home/notebook/config/zshenv
~/.zshrc      → /home/notebook/config/zshrc
~/.vimrc      → /home/notebook/config/vimrc
~/.vim        → /home/notebook/config/vim
```

### Integração com Windows
```bash
# AWS & Azure (Compartilhados com Windows)
~/.aws   → /mnt/c/Users/valor/.aws/
~/.azure → /mnt/c/Users/valor/.azure/

# Acesso Windows → WSL2
\wsl.localhost\Ubuntu\

# Acesso WSL2 → Windows
/mnt/c/  # Drive C:
/mnt/d/  # Drive D:
```

### Arquivo .env
- Status: ✓ Configurado com 14 variáveis
- Path: `~/.env`
- Carregado automaticamente pelo zshrc
- **NUNCA** fazer commit deste arquivo

---

## 🚀 VSCode - Automação Completa com Tasks

### Criar Estrutura de Automação
```bash
mkdir -p ~/workspace/.vscode
```

### tasks.json - Múltiplos Terminais Automáticos
```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "🚀 Abrir Terminais Workspace",
      "type": "shell",
      "command": "echo",
      "args": ["Iniciando terminais do workspace..."],
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "dependsOn": [
        "Terminal: Workspace Raiz",
        "Terminal: Learning",
        "Terminal: Config",
        "Terminal: Docker Monitor"
      ],
      "dependsOrder": "parallel",
      "runOptions": {
        "runOn": "folderOpen"
      }
    },
    {
      "label": "Terminal: Workspace Raiz",
      "type": "shell",
      "command": "zsh",
      "args": ["-l"],
      "options": {
        "cwd": "/home/joao/workspace",
        "shell": {
          "executable": "/usr/bin/zsh"
        }
      },
      "isBackground": true,
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "dedicated",
        "showReuseMessage": false,
        "group": "workspace-terminals"
      }
    },
    {
      "label": "Terminal: Learning",
      "type": "shell",
      "command": "zsh",
      "args": ["-l"],
      "options": {
        "cwd": "/home/joao/workspace/learning"
      },
      "isBackground": true,
      "presentation": {
        "panel": "dedicated",
        "group": "workspace-terminals"
      }
    },
    {
      "label": "Terminal: Config",
      "type": "shell",
      "command": "zsh",
      "args": ["-l"],
      "options": {
        "cwd": "/home/joao/config"
      },
      "isBackground": true,
      "presentation": {
        "panel": "dedicated",
        "group": "workspace-terminals"
      }
    },
    {
      "label": "Terminal: Docker Monitor",
      "type": "shell",
      "command": "docker",
      "args": ["ps", "--format", "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}"],
      "presentation": {
        "panel": "dedicated",
        "group": "workspace-terminals"
      }
    }
  ]
}
```

### keybindings.json - Atalhos Personalizados
```json
[
  {
    "key": "ctrl+alt+t",
    "command": "workbench.action.terminal.newInActiveWorkspace",
    "args": {
      "location": "editor"
    }
  },
  {
    "key": "ctrl+alt+shift+t",
    "command": "workbench.action.tasks.runTask",
    "args": "🚀 Abrir Terminais Workspace"
  }
]
```

### settings.json - Configurações do Workspace
```json
{
  "terminal.integrated.defaultProfile.linux": "zsh",
  "terminal.integrated.profiles.linux": {
    "zsh": {
      "path": "/usr/bin/zsh",
      "args": ["-l"]
    }
  },
  "files.watcherExclude": {
    "**/.git/**": true,
    "**/node_modules/**": true,
    "**/.vscode-server/**": true
  },
  "editor.formatOnSave": true,
  "editor.minimap.enabled": false,
  "workbench.startupEditor": "none",
  "C_Cpp.default.configurationProvider": "mesonbuild.mesonbuild"
}
```

---

## 🐳 Docker & DevOps - Desenvolvimento Containerizado

### ✅ Docker Desktop Status - **INTEGRAÇÃO WSL2 ATIVADA**

| Componente | Status | Detalhes |
|------------|--------|---------|
| **Docker Desktop** | ✅ | v28.4.0 funcionando com integração WSL2 |
| **Docker Compose** | ✅ | v2.39.2-desktop.1 ativo |
| **Comando `docker`** | ✅ | Disponível no WSL2 Ubuntu |
| **Recursos** | ✅ | 4 CPUs, 5.788GiB memória |
| **Imagens** | ✅ | 18 imagens disponíveis |
| **Containers** | ✅ | 19 containers (incluindo Kubernetes) |

#### 🎉 **Problema Resolvido (15/09/2025)**

**Status Anterior**: ❌ Comando `docker` não encontrado  
**Status Atual**: ✅ Docker Desktop totalmente funcional

```bash
# Verificação atual:
$ docker --version
Docker version 28.4.0, build d8eb465

$ docker-compose --version  
Docker Compose version v2.39.2-desktop.1

# Teste de funcionamento:
$ docker run --rm hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

#### 📋 Recursos Ativos
- **Docker Engine**: v28.4.0 com WSL2 backend
- **Docker Compose**: v2.39.2 para orquestração
- **Kubernetes**: Cluster local ativo (18 pods rodando)
- **Imagens**: PostgreSQL 16-alpine, Nginx Alpine, etc.
- **Integração**: Completa com WSL2 Ubuntu 24.04.3

### ⚙️ **Kubernetes Local Descoberto**

🎉 **Surpresa**: Docker Desktop inclui cluster Kubernetes totalmente funcional!

**Recursos Ativos:**
- ✅ **18 pods Kubernetes** rodando automaticamente
- ✅ **CoreDNS** para resolução de nomes
- ✅ **Storage Provisioner** para volumes
- ✅ **Kube-proxy** para networking
- ✅ **API Server, Scheduler, Controller** completos

```bash
# Containers Kubernetes detectados:
kube-apiserver, kube-scheduler, kube-controller-manager, etcd
coredns, kube-proxy, storage-provisioner, vpnkit-controller
```

**Potencial de Uso:**
- Desenvolvimento local com Kubernetes nativo
- Testes de deploying sem cloud
- Aprendizado de orquestração de containers
- CI/CD pipelines locais
- Integração WSL2: ✓ Habilitada

### Desenvolvimento C com Docker

#### Dockerfile.dev - Ambiente Completo
```dockerfile
FROM ubuntu:24.04

# Instalar ferramentas de desenvolvimento
RUN apt-get update && apt-get install -y \
    gcc build-essential meson ninja-build git \
    libcmark-dev valgrind gdb cmake clang lldb \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário de desenvolvimento
RUN useradd -m -s /bin/bash dev

WORKDIR /workspace
VOLUME ["/workspace"]
USER dev

CMD ["bash"]
```

#### docker-compose.dev.yml - Stack Completa
```yaml
version: '3.8'

services:
  dev:
    build: 
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/workspace
      - build_cache:/workspace/build
    ports:
      - "8080:8080"
    tty: true
    stdin_open: true
    environment:
      - TERM=xterm-256color
  
  web:
    image: nginx:alpine
    ports:
      - "3000:80"
    volumes:
      - ./output:/usr/share/nginx/html:ro
    depends_on:
      - dev

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_PASSWORD: dev
      POSTGRES_DB: app
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  build_cache:
  db_data:
```

### Comandos Docker Úteis
```bash
# Build e execução
docker-compose -f docker-compose.dev.yml build
docker-compose -f docker-compose.dev.yml up -d
docker-compose -f docker-compose.dev.yml exec dev bash

# Monitoramento
docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}"
docker stats --no-stream
docker-compose logs -f

# Limpeza
docker-compose down
docker system prune -af
docker volume prune -f
```

---

## 🔄 Aliases e Funções de Produtividade

### Aliases Docker
```bash
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"
alias dprune="docker system prune -af"
```

### Aliases Git
```bash
alias gst="git status -sb"
alias gco="git checkout"
alias gcm="git commit -m"
alias glog="git log --oneline --graph --decorate"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gb="git branch"
alias gba="git branch -a"
```

### Aliases de Navegação
```bash
alias ws="cd ~/workspace"
alias conf="cd ~/config"
alias learning="cd ~/workspace/learning"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
```

### Aliases de Desenvolvimento
```bash
alias py="python3"
alias make="make -j$(nproc)"
alias ports="netstat -tulanp"
alias reload="source ~/.zshrc && source ~/.p10k.zsh"
```

---

## 🎓 Progressão de Aprendizado Recomendada

### Semana 1-2: Fundamentos
- Dominar navegação Vim (hjkl)
- Configurar ambiente WSL2
- Entender estrutura de workspaces
- Praticar comandos básicos Git

### Semana 3-4: Eficiência
- Aprender text objects no Vim
- Configurar Docker para desenvolvimento
- Usar FZF para busca rápida
- Dominar Yazi para navegação

### Mês 2: Produtividade
- Criar macros no Vim
- Configurar LSP para suas linguagens
- Automatizar com tasks.json
- Integrar Git workflow

### Mês 3: Maestria
- Desenvolver snippets personalizados
- Criar pipelines CI/CD
- Configurar Kubernetes local
- Otimizar performance do sistema

---

## 🎯 Próximos Passos Baseados no Diagnóstico (15/09/2025)

### 🔴 **Crítico - Correções Urgentes**

#### 1. ✓ **Docker Desktop - Integração WSL2**
**Status**: ✅ **RESOLVIDO** - Docker v28.4.0 ativo  
**Ação**: ✓ Integração WSL2 ativada com sucesso  
**Resultado**: 18 imagens, 19 containers, Kubernetes local

#### 2. ⬜ **Build Tools Modernos**
**Status**: 🔵 Faltando `meson` e `ninja`  
**Ação**: 
```bash
sudo apt update
sudo apt install meson ninja-build
```
**Justificativa**: Ferramentas de build 2024-2025 (100x mais rápido que Make)

#### 3. ⬜ **Ferramenta de Busca `fd`**
**Status**: 🔵 Faltando (usado pelo FZF)  
**Ação**: 
```bash
sudo apt install fd-find
ln -s /usr/bin/fdfind ~/.local/bin/fd
```
**Impacto**: Melhora performance do FZF no Vim

### 🟡 **Importante - Atualizações Recomendadas**

#### 4. ⬜ **Atualizar Tasks.json VSCode**
**Status**: ✅ Configurado, mas caminhos incorretos  
**Ação**: Corrigir paths de `/home/joao/` para `/home/notebook/`  
**Localização**: `~/workspace/.vscode/tasks.json`

#### 5. ✓ **VSCode Workspace Tasks**
**Status**: ✅ **JÁ CONFIGURADO** com terminais automáticos  
**Funcional**: 3 terminais (Workspace, Learning, Config)

#### 6. ✓ **Links Simbólicos**
**Status**: ✅ **TODOS FUNCIONAIS**  
**Confirmado**: `.zshrc`, `.vimrc`, `.bashrc`, `.gitconfig`

### 🟠 **Opcional - Melhorias de Produtividade**

#### 7. ⬜ **Instalar C Development Libraries**
**Ação**: 
```bash
sudo apt install libcmark-dev build-essential cmake
```
**Finalidade**: Suporte completo para desenvolvimento C mencionado no contexto

#### 8. ⬜ **Configurar Kernel WSL2 Update**
**Status**: 🔄 Kernel 6.6.87.2 (data futura detectada)  
**Ação**: Executar `wsl --update` no Windows para sincronizar

### Ongoing
- Monitorar performance do sistema
- Atualizar ferramentas regularmente
- Documentar customizações adicionais
- Fazer backup semanal das configurações

---

## 📝 Notas de Manutenção

- **Backup regular**: Configurações em `~/config/` devem ser versionadas
- **Tokens e segredos**: Sempre em `~/.env`, nunca commitados
- **Atualizações**: Executar `PlugUpdate` no Vim mensalmente
- **Docker**: Manter Docker Desktop atualizado no Windows
- **WSL**: Executar `wsl --update` periodicamente

---

## 🔧 Scripts de Automação Incluídos

Esta seção documenta os 3 scripts funcionais essenciais mantidos neste repositório de configurações.

### `sync-vim-config.sh` - Sincronização Vim
**Propósito:** Sincroniza toda a estrutura do Vim para ~/config/ com links simbólicos  
**Uso:** `./sync-vim-config.sh`  
**Funcionalidades:**
- ✅ Backup automático com timestamp
- ✅ Cópia completa de ~/.vim para ~/config/vim/
- ✅ Criação de links simbólicos corretos (~/.vim → ~/config/vim/)
- ✅ Verificação de integridade da configuração
- ✅ Interface interativa com confirmação

**Fluxo de Execução:**
1. Verifica estrutura atual do Vim
2. Cria backup da configuração existente
3. Copia toda estrutura ~/.vim para ~/config/vim/
4. Estabelece links simbólicos
5. Valida resultado final

### `diagnostico-ambiente.sh` - Diagnóstico WSL
**Propósito:** Diagnóstico completo de 20+ componentes do ambiente WSL  
**Uso:** `./diagnostico-ambiente.sh`  
**Funcionalidades:**
- ✅ Verifica links simbólicos dos dotfiles
- ✅ Testa ferramentas de desenvolvimento (Git, Node, Python, etc.)
- ✅ Analisa estrutura de diretórios
- ✅ Valida configurações VSCode e Windows Terminal
- ✅ Gera relatório com percentual de sucesso
- ✅ Fornece sugestões específicas de correção

**Seções do Diagnóstico:**
1. Verificação do Sistema (WSL, kernel, distribuição)
2. Links Simbólicos dos Dotfiles
3. Estrutura de Diretórios (~/config, ~/workspace)
4. Ferramentas de Desenvolvimento
5. Configuração do VSCode
6. Plugins do Vim
7. Integração com Windows Terminal
8. Configurações VSCode para WSL
9. Testes de Funcionalidade
10. Resumo de Status com percentual

### `vim-diagnostic.sh` - Diagnóstico Vim
**Propósito:** Diagnóstico específico e detalhado das configurações Vim  
**Uso:** `./vim-diagnostic.sh`  
**Funcionalidades:**
- ✅ Verifica instalação e versão do Vim
- ✅ Testa 17 plugins instalados
- ✅ Analisa configuração centralizada (520 linhas)
- ✅ Valida LSP, FZF, Git integration
- ✅ Estatísticas de uso e performance
- ✅ Recomendações de otimização

**Verificações Realizadas:**
1. **Verificações Básicas:** Vim instalado, versão, configuração centralizada
2. **Estrutura de Diretórios:** ~/.vim, undodir, spell
3. **Sistema de Plugins:** vim-plug, ~/.vim/plugged, plugins ativos
4. **Configurações Principais:** vimrc, true color, undo persistente, tema
5. **Testes Funcionais:** Carregamento, syntax highlighting, colorscheme
6. **Estatísticas:** Localização, espaço ocupado, última modificação
7. **Recomendações:** Sugestões de melhorias e otimizações

---

---

## 🎯 Resumo das Últimas Atualizações (21/09/2025)

### 🚀 **VIM MODERNIZADO** - Terminal Integrado e Workflow Otimizado
- **🆕 Terminal Integrado**: `,t` abre terminal em modo only (tela cheia)
- **🆕 Tab-First Workflow**: Todos os arquivos abrem em novas abas automaticamente
- **🆕 Folding Inteligente**: Código sempre expandido por padrão (foldlevelstart=99)
- **🆕 Comando :Vimrc**: Acesso instantâneo às configurações (`,ev`)
- **🆕 Navegação Terminal**: `<Esc><Esc>` para sair, `,h/j/k/l` para navegar
- **615+ linhas** de configuração (+20 linhas de melhorias)

### 🎮 **COMANDOS NOVOS IMPLEMENTADOS**
```vim
,t              " Terminal tela cheia com :only
,ev             " Editar vimrc em nova aba
:Vimrc          " Comando personalizado para vimrc
:e arquivo      " Sempre abre em nova aba (automático)
:E arquivo      " Comando explícito para nova aba
<Esc><Esc>      " Sair do modo terminal
```

### ⚙️ **CONFIGURAÇÕES AUTOMATIZADAS**
- **switchbuf=newtab**: Quickfix e help sempre em abas
- **showtabline=2**: Linha de abas sempre visível
- **foldlevelstart=99**: Código expandido por padrão
- **Terminal ++curwin**: Força terminal na janela atual

### 🚀 **WARP TERMINAL** - Terminal Principal (Mantido)
- **Terminal ativo**: Warp Terminal detectado via $TERM_PROGRAM
- **Integração WSL2**: ✅ Funcionando perfeitamente
- **Compatibilidade**: Total com todas as novas funcionalidades Vim

### 🤖 **Claude Code** - Configuração Otimizada (Mantida)
- **v1.0.113** funcionando perfeitamente no Warp Terminal
- **Auto-updates funcionando** corretamente
- **Integração completa** com novo workflow Vim

### ✅ **Sistema de Completion Profissional** (Mantido)
- **MuComplete instalado** e integrado com vsnip + LSP
- **18 plugins totais** (17 + MuComplete)
- **Chains por linguagem** configuradas e funcionais
- **Completion contextual** ativo e otimizado

### 🔧 **Melhorias de Produtividade Aplicadas**
- **Workflow baseado em abas**: Organização visual superior
- **Terminal dedicado**: Foco total em comandos shell
- **Configuração acessível**: Edição instantânea de settings
- **Código sempre visível**: Sem surpresas de folding fechado
- **Navegação intuitiva**: Atalhos consistentes e memoráveis

### 📋 **Funcionalidades Ativas Expandidas**
- **Terminal integrado** com modo only automático
- **Tab-first workflow** para todos os comandos de arquivo
- **Folding inteligente** com código expandido
- **Comando :Vimrc** para configuração rápida
- **Auto-completion contextual** mantida
- **LSP integration** otimizada e funcional

---

**📅 Criado:** 18/08/2025
**🔄 Última atualização:** 21/09/2025
**✅ Status:** Sistema profissional 100% implementado + Vim modernizado com terminal integrado e workflow em abas
**📍 Localização principal:** `/home/notebook/config/`
**🚀 Comandos rápidos:** `,t` (terminal) | `,ev` (editar vimrc) | `claude doctor` | `./vim-diagnostic.sh` | `reload` | `yy`
