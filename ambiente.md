# 🔍 Relatório de Diagnóstico do Ambiente de Desenvolvimento
**Data de Geração:** 11/08/2025  
**Última Atualização:** 11/08/2025 - Consolidação Completa com Paths Preservados  
**Sistema:** Windows 11 + WSL2 (Ubuntu 24.04) + VSCode + Warp + Zsh  
**Usuário:** joao  
**Diretório Base:** `/home/joao/workspace`  
**Arquivo Único:** Este arquivo em `/home/joao/workspace/ambiente.md`

## 📋 Índice
- [Resumo Executivo](#resumo-executivo)
- [Ferramentas Principais](#ferramentas-principais)
- [Estrutura WSL2](#estrutura-wsl2)
- [Estrutura do Workspace](#estrutura-do-workspace)
- [Configurações Centralizadas](#configurações-centralizadas)
- [Warp Terminal](#warp-terminal)
- [VSCode Automação](#vscode-automação)
- [Status de Verificação](#status-de-verificação)
- [Comandos Úteis](#comandos-úteis)
- [Troubleshooting](#troubleshooting)

---

## 📊 Resumo Executivo

### ✅ Pontos Fortes
- Ambiente WSL2 configurado corretamente com Ubuntu 24.04 LTS
- Zsh com Oh My Zsh e plugins essenciais instalados
- Toolchain de desenvolvimento robusto (GCC 13.3, Node 22.15, Python 3.12)
- Configuração de dotfiles centralizada em `~/config/`
- Integração com Warp Terminal funcionando
- Rust/Cargo configurado para desenvolvimento moderno (1.89.0)
- Docker Desktop integrado com WSL2 (v28.3.2)
- Kubernetes local configurado e funcional (v1.30.5)
- Performance de shell excelente (478ms)
- Build tools modernos: CMake 3.28.3, Meson 1.3.2, Ninja 1.11.1
- Vim com 17 plugins instalados e configurados

### ⚠️ Áreas de Atenção
- Configurações VSCode não centralizadas (❌ .vscode não existe)
- Falta de backup automático de configurações (❌ script não criado)
- SSH Agent funcionando mas sem persistência configurada
- Arquivo `.env` configurado com 14 variáveis (✅)

### 🚨 Problemas Críticos
- Sem diretório `.vscode` no workspace principal (❌ Confirmado)
- Powerlevel10k instant prompt desabilitado (mas performance ainda boa)
- Aliases de produtividade não implementados (❌ Não encontrados)
- libcmark-dev não instalado para desenvolvimento C

---

## 📋 Status de Verificação Detalhada

### **Itens Verificados e Status Atual**

| Componente | Status Esperado | Status Real | Ação Necessária |
|------------|----------------|-------------|-----------------|
| WSL Version | 2.5.9.0 | ✅ 2.5.9.0 | Nenhuma |
| Memória RAM | 5.8GB | ✅ 5.8GB (4.2GB livre) | Nenhuma |
| Performance Shell | <500ms | ✅ 478ms | Opcional: instant prompt |
| .vscode folder | Existe | ❌ Não existe | Criar urgente |
| SSH Agent | Persistente | ⚠️ Funciona mas não persiste | Configurar persistência |
| Backup Script | Configurado | ❌ Não existe | Criar script |
| Aliases Docker/Git | Configurados | ❌ Não encontrados | Adicionar ao zshrc |
| libcmark-dev | Instalado | ❌ Não instalado | Instalar para C dev |
| .wslconfig | Otimizado | ✅ Existe mas não otimizado | Atualizar config |
| VSCode Extensions | >10 | ❌ Apenas 5 | Instalar essenciais |
| Vim Plugins | 13+ | ✅ 17 instalados | Nenhuma |
| .env file | Configurado | ✅ 14 variáveis | Nenhuma |
| Build Tools | CMake/Meson/Ninja | ✅ Todos instalados | Nenhuma |
| Tasks.json | Configurado | ❌ Não existe | Criar para automação |

---

## 🛠️ Ferramentas Principais

### Docker & Docker Desktop
**Localização Windows (acessível via WSL2):**
```bash
/mnt/c/Program Files/Docker/Docker/
```
**Integração WSL2:** ✅ Habilitada
- Docker v28.3.2 funcionando nativamente no WSL2
- Docker Compose v2.38.2 disponível
- Kubernetes v1.30.5 local configurado
- 15 imagens Docker disponíveis (2.1GB)

### VS Code
**Instalação Principal (Windows via WSL2):**
```bash
/mnt/c/Users/valor/AppData/Local/Programs/Microsoft VS Code/
```

**Configurações Windows:**
```bash
/mnt/c/Users/valor/AppData/Roaming/Code/User/settings.json
/mnt/c/Users/valor/AppData/Roaming/Code/User/keybindings.json
/mnt/c/Users/valor/.vscode/
```

**Extensões Instaladas Atualmente:**
- Anthropic Claude Code
- GitHub Copilot (+ Chat)
- Rust Analyzer
- LLDB Debugger
❌ **Faltando:** C/C++ Extension Pack, Remote-WSL, Docker, GitLens

### Windows Terminal
**Configurações (acessível via WSL2):**
```bash
/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

**Git Bash (Windows):**
```bash
/mnt/c/Programação/Git/bin/bash.exe
```

### Warp Terminal
**Status:** ✅ Integrado e funcionando
- TERM_PROGRAM: WarpTerminal detectado
- Performance shell: 478ms (excelente)
- Configurações residem no Windows host

## 🖥️ Análise Detalhada do Sistema

### 1. Sistema Operacional e WSL

#### **Informações do Sistema**
```
Kernel: 6.6.87.2-microsoft-standard-WSL2
Distribuição: Ubuntu 24.04.2 LTS (Noble)
WSL Version: 2.5.9.0
Arquitetura: x86_64
Processador: Intel Core i7-7500U @ 2.70GHz
Memória Host: 8.00 GB (7.88 GB utilizável)
```

#### **Acesso ao Sistema de Arquivos**
```bash
# Acesso Windows → WSL2
\\wsl.localhost\Ubuntu\

# Acesso WSL2 → Windows
/mnt/c/  # Drive C:
/mnt/d/  # Drive D: (se existir)
```

#### **.wslconfig (Windows):**
```bash
/mnt/c/Users/valor/.wslconfig  # ✅ Existe mas não otimizado
```

### 2. Recursos do Sistema

#### **Memória e Armazenamento**
```
RAM Total: 5.8 GB (4.2 GB livre)
Swap: 2.0 GB configurado
Disco: 1007 GB total, 16 GB usado (2% ocupação)
.wslconfig: Existe mas não otimizado
```

### 3. Ferramentas de Desenvolvimento

#### **Versões Instaladas**
| Ferramenta | Versão | Status | Path/Comando |
|------------|--------|--------|-------------|
| Git | 2.43.0 | ✅ | `/usr/bin/git` |
| Node.js | 22.15.0 | ✅ | `/usr/bin/node` |
| NPM | 10.9.2 | ✅ | `/usr/bin/npm` |
| Python | 3.12.3 | ✅ | `/usr/bin/python3` |
| GCC | 13.3.0 | ✅ | `/usr/bin/gcc` |
| Rust | 1.89.0 | ✅ | `~/.cargo/bin/rustc` |
| Cargo | 1.89.0 | ✅ | `~/.cargo/bin/cargo` |
| CMake | 3.28.3 | ✅ | `/usr/bin/cmake` |
| Meson | 1.3.2 | ✅ | `/usr/bin/meson` |
| Ninja | 1.11.1 | ✅ | `/usr/bin/ninja` |
| Vim | 9.1 | ✅ | `/usr/bin/vim` |
| Docker | 28.3.2 | ✅ | Via Docker Desktop |

### 4. Shell e Terminal

#### **Configuração Zsh**
```
Shell: /usr/bin/zsh (versão 5.9)
Framework: Oh My Zsh (~/.oh-my-zsh)
Tema: powerlevel10k
Terminal: Warp Terminal
Performance: 478ms (✅ Ótimo - abaixo de 500ms)
TERM_PROGRAM: WarpTerminal (✅ Detectado)
```

#### **Plugins Oh My Zsh Instalados**
- git
- zsh-autosuggestions
- z (navegação rápida)
- zsh-syntax-highlighting  
- zsh-autocomplete

#### **Configuração Powerlevel10k**
- Arquivo: `~/.p10k.zsh` → `/home/joao/config/p10k.zsh`
- ⚠️ Instant prompt desabilitado (linhas 14-20 do zshrc comentadas)

---

## 🎯 Warp Terminal - Configuração e Atalhos

### **Atalhos Essenciais do Warp (WSL)**

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
| Navegar entre abas | `CTRL+1` até `CTRL+9` | Ir direto para aba específica |

### **Workflows Recomendados para Warp**

#### 1. **Workflow de Desenvolvimento Multi-Projeto**
```yaml
# Criar arquivo: ~/.warp/workflows/dev-workspace.yml
name: "Workspace Development"
commands:
  - "cd ~/workspace && clear"
  - "cd ~/workspace/learning && ls -la"
  - "cd ~/config && vim zshrc"
  - "cd ~/workspace && git status"
```

#### 2. **Launch Configuration para Projetos**
```json
# Configurar no Warp Settings > Launch Configurations
{
  "profiles": [
    {
      "name": "Site WM Project",
      "cwd": "/home/joao/workspace/learning/site_wm",
      "command": "npm start"
    },
    {
      "name": "Config Editor",
      "cwd": "/home/joao/config",
      "command": "vim"
    },
    {
      "name": "Learning Projects",
      "cwd": "/home/joao/workspace/learning",
      "command": "ls -la"
    }
  ]
}
```

---

## 💻 VSCode - Automação com Tasks

### **Criar tasks.json para Múltiplos Terminais**

Baseado no contexto de tasks VSCode fornecido, aqui está a configuração otimizada:

```bash
# Criar estrutura de automação
mkdir -p ~/workspace/.vscode
cat > ~/workspace/.vscode/tasks.json << 'EOF'
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
      },
      "presentation": {
        "echo": false,
        "reveal": "silent",
        "focus": false,
        "panel": "shared"
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
        "cwd": "/home/joao/workspace/learning",
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
      "label": "Terminal: Config",
      "type": "shell",
      "command": "zsh",
      "args": ["-l"],
      "options": {
        "cwd": "/home/joao/config",
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
      "label": "Terminal: Docker Monitor",
      "type": "shell",
      "command": "docker",
      "args": ["ps", "--format", "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}"],
      "options": {
        "cwd": "/home/joao/workspace"
      },
      "isBackground": false,
      "problemMatcher": [],
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "dedicated",
        "showReuseMessage": false,
        "group": "workspace-terminals"
      }
    }
  ]
}
EOF
```

### **Keybindings para Produtividade**

```bash
# Criar atalhos personalizados
cat > ~/workspace/.vscode/keybindings.json << 'EOF'
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
  },
  {
    "key": "ctrl+shift+g",
    "command": "workbench.view.scm"
  },
  {
    "key": "ctrl+shift+d",
    "command": "workbench.view.debug"
  }
]
EOF
```

---

## ⚙️ Configurações Centralizadas

### 📂 Diretório `/home/joao/config/`
Todas as configurações principais são centralizadas via links simbólicos:

```bash
# Links Simbólicos Ativos
~/.bashrc     → /home/joao/config/bashrc
~/.gitconfig  → /home/joao/config/gitconfig  
~/.fzf.zsh    → /home/joao/config/fzf.zsh
~/.fzf.bash   → /home/joao/config/fzf.bash
~/.profile    → /home/joao/config/profile
~/.p10k.zsh   → /home/joao/config/p10k.zsh
~/.zshenv     → /home/joao/config/zshenv
~/.zshrc      → /home/joao/config/zshrc
~/.vimrc      → /home/joao/config/vimrc
```

### 🔗 Integração com Windows
```bash
# AWS & Azure (Compartilhados com Windows)
~/.aws   → /mnt/c/Users/valor/.aws/
~/.azure → /mnt/c/Users/valor/.azure/
```

### 📝 Arquivo .env
- Status: ✅ Configurado com 14 variáveis
- Path: `~/.env`
- Carregado automaticamente pelo zshrc

## 🔧 Otimizações Recomendadas (Prioridade Alta)

### 1. **Criar Estrutura .vscode no Workspace**
```bash
mkdir -p ~/workspace/.vscode
cat > ~/workspace/.vscode/settings.json << 'EOF'
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
  "workbench.startupEditor": "none"
}
EOF
```

### 2. **Instalar libcmark-dev para Desenvolvimento C**
```bash
sudo apt update && sudo apt install -y libcmark-dev
```

### 3. **Adicionar Aliases de Produtividade**
```bash
cat >> ~/config/zshrc << 'EOF'

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

# Navegação rápida
alias ws="cd ~/workspace"
alias conf="cd ~/config"
alias learning="cd ~/workspace/learning"

# Desenvolvimento
alias py="python3"
alias make="make -j$(nproc)"
alias ports="netstat -tulanp"

# Reload configurations
alias reload="source ~/.zshrc && source ~/.p10k.zsh"
EOF

# Recarregar configurações
source ~/.zshrc
```

### 4. **Instalar Extensões VSCode Essenciais**
```bash
# Extensões recomendadas para seu ambiente
code --install-extension ms-vscode.cpptools
code --install-extension ms-python.python
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension eamodio.gitlens
code --install-extension PKief.material-icon-theme
code --install-extension ms-azuretools.vscode-docker
```

### 5. **Configurar SSH Agent Persistente**
```bash
# Substituir configuração atual no zshrc
cat >> ~/config/zshrc << 'EOF'

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
EOF
```

### 6. **Reabilitar Powerlevel10k Instant Prompt**
```bash
# Editar ~/config/zshrc
vim ~/config/zshrc
# Descomentar linhas 14-20 (instant prompt)
# Salvar e recarregar:
source ~/.zshrc
```

---

## 🐳 Desenvolvimento DevOps com Docker

### **Dockerfile para Desenvolvimento C**
```dockerfile
# Dockerfile.dev para desenvolvimento C
FROM ubuntu:24.04
RUN apt-get update && apt-get install -y \
    gcc build-essential meson ninja-build \
    git libcmark-dev valgrind gdb \
    cmake clang lldb
WORKDIR /workspace
CMD ["bash"]
```

### **Docker Compose para Desenvolvimento**
```yaml
# docker-compose.dev.yml
version: '3.8'
services:
  dev:
    build: 
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/workspace
    tty: true
    stdin_open: true
  
  web:
    image: nginx:alpine
    ports:
      - "3000:80"
    volumes:
      - ./output:/usr/share/nginx/html:ro
```

---

## 🎮 Vim - Configuração Completa

### **Status:** ✅ Configurado e Funcional
- **Versão:** 9.1
- **Configuração:** `~/.vimrc` → `/home/joao/config/vimrc`
- **Plugins:** 17 instalados em `~/.vim/plugged/`

### **Plugins Instalados**
```bash
# Principais plugins disponíveis
fzf + fzf.vim          # Busca fuzzy de arquivos
vim-airline            # Barra de status avançada  
emmet-vim              # Expansão HTML/CSS rápida
nerdcommenter          # Comentários inteligentes
typescript-vim         # Suporte TypeScript
dockerfile.vim         # Syntax highlighting Docker
vim-lsp                # Language Server Protocol
vim-surround           # Manipulação de delimitadores
vim-fugitive           # Integração Git
vim-devicons           # Ícones no editor
vim-vsnip              # Snippets
friendly-snippets      # Coleção de snippets
```

### **Recursos Configurados**
- **Tema:** habamax com transparência
- **Números:** Relativos + absolutos
- **Indentação:** 4 espaços, auto-indent
- **Busca:** Case-insensitive com highlight
- **Statusline:** Airline com tema base16
- **Undo:** Persistente em `~/.vim/undodir`
- **LSP:** Configurado para C, Python, TypeScript

### **Atalhos Personalizados**
```vim
" FZF
Ctrl+P         # Buscar arquivos
Ctrl+B         # Buffers abertos
Ctrl+F         # Busca com ripgrep

" Git (Fugitive)
<leader>gs     # Git status
<leader>ga     # Git add .
<leader>gc     # Git commit
<leader>gp     # Git push
<leader>gd     # Git diff

" LSP
gd             # Go to definition
gr             # Find references
K              # Hover documentation
[g / ]g        # Navigate diagnostics
```

## 📁 Estrutura do Workspace Atual

```
/home/joao/workspace/
├── 📚 learning/              # Projetos de Aprendizado
│   ├── material_estudo/      # Documentação estruturada
│   ├── site_wm/             # Projeto Site WM
│   └── app-controle/        # Aplicação de controle
├── 🚀 rodando/              # Projetos em Produção
├── 📄 *.code-workspace      # 8 arquivos de workspace VSCode
├── 📋 ambiente.md           # Este arquivo (fonte única)
└── 📖 README.md             # Documentação geral
```

---

## 🎯 Plano de Ação Imediato

### Semana 1 - Correções Críticas
1. ⬜ Criar estrutura .vscode no workspace
2. ⬜ Instalar libcmark-dev
3. ⬜ Adicionar aliases de produtividade
4. ⬜ Configurar tasks.json para automação

### Semana 2 - Otimizações
5. ⬜ Configurar SSH Agent persistente
6. ⬜ Implementar backup automático
7. ⬜ Otimizar configuração do WSL2
8. ⬜ Instalar extensões VSCode essenciais

### Ongoing
- Monitorar performance do sistema
- Atualizar ferramentas regularmente
- Documentar customizações adicionais
- Fazer backup semanal das configurações

---

## 💡 Comandos Úteis

### Verificação do Ambiente
```bash
# Status das ferramentas
git --version
node --version
npm --version
docker --version
vim --version | head -1
rustc --version
meson --version

# Verificar links simbólicos
ls -la ~/.bashrc ~/.gitconfig ~/.zshrc ~/.vimrc

# PATH atual (primeiras 10 entradas)
echo $PATH | tr ':' '\n' | head -10

# Performance do shell
time zsh -i -c exit
```

### Recarregar Configurações
```bash
# Recarregar ZSH completo
source ~/.zshrc && source ~/.p10k.zsh

# Recarregar perfil completo
exec zsh

# Alias configurado
reload  # Se os aliases forem adicionados
```

### Git Configuration
```bash
# Configurar informações pessoais
git config --global user.name "João Carlos Pelegrino"
git config --global user.email "pelegrinojoaocarlos@gmail.com"

# Verificar configuração
git config --list

# Configurações atuais otimizadas para WSL2
git config --global core.autocrlf input    # ✅ Configurado
git config --global credential.helper store # ✅ Configurado
```

---

## 🔧 Troubleshooting

### Problemas Comuns

**1. Links simbólicos quebrados:**
```bash
# Verificar se o diretório existe
ls -la /home/joao/config/

# Recriar link se necessário
ln -sf /home/joao/config/bashrc ~/.bashrc
ln -sf /home/joao/config/zshrc ~/.zshrc
```

**2. PATH com duplicações:**
```bash
# Verificar duplicações
echo $PATH | tr ':' '\n' | sort | uniq -d

# O .zshrc está configurado para evitar duplicações automaticamente
```

**3. SSH Agent não iniciando:**
```bash
# Verificar processo
ps aux | grep ssh-agent

# Reiniciar manualmente
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**4. VS Code não abrindo no WSL:**
```bash
# Testar comando
code --version

# Instalar extensão WSL se necessário
code --install-extension ms-vscode-remote.remote-wsl
```

**5. Docker não funcionando:**
```bash
# Verificar integração WSL2
docker --version

# Se não funcionar, verificar Docker Desktop:
# Settings → Resources → WSL Integration
# Habilitar integração com Ubuntu
```

**6. Warp Terminal lento:**
```bash
# Verificar performance
time zsh -i -c exit

# Se > 1s, desabilitar plugins pesados
# Editar ~/.zshrc e comentar plugins suspeitos
```

### Arquivos de Log
```bash
# Histórico ZSH
~/.zsh_history

# Logs SSH
~/.ssh/known_hosts

# Cache e temporários
~/.cache/
```

---

## 🗒 Notas Finais

### Ferramentas Verificadas e Funcionais
- ✅ Docker Desktop integrado com Kubernetes
- ✅ Rust/Cargo configurado e funcional
- ✅ GCC 13.3 com suporte C23
- ✅ Build tools modernos (CMake, Meson, Ninja)
- ✅ Vim com 17 plugins
- ✅ Warp Terminal integrado

### Próximos Passos Críticos
1. **VSCode**: Centralizar configurações para consistência
2. **Backup**: Implementar sistema de backup para preservar configurações
3. **Performance**: Reabilitar Powerlevel10k instant prompt
4. **C Development**: Instalar libcmark-dev para projetos C

---

## 🔗 Referências Úteis
- [WSL2 Best Practices](https://docs.microsoft.com/en-us/windows/wsl/best-practices)
- [Docker Desktop WSL2 Integration](https://docs.docker.com/desktop/wsl/)
- [Warp Terminal Documentation](https://docs.warp.dev/)
- [Oh My Zsh Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [VSCode Remote Development](https://code.visualstudio.com/docs/remote/wsl)

---

**Relatório gerado automaticamente por Agent Mode**  
**Para atualizar este relatório, execute:** `warp-agent diagnose-env`
