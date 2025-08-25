# 🔧 Ambiente de Desenvolvimento - WSL2 + Windows

## 📋 Índice
- [Ferramentas Principais](#ferramentas-principais)
- [Estrutura WSL2](#estrutura-wsl2)
- [Estrutura do Workspace](#estrutura-do-workspace)
- [Configurações Centralizadas](#configurações-centralizadas)
- [Comandos Úteis](#comandos-úteis)
- [Troubleshooting](#troubleshooting)

---

## 🛠️ Ferramentas Principais usadas

### Docker & Docker Desktop
**Localização Windows (acessível via WSL2):**
```bash
/mnt/c/Program Files/Docker
```
**Integração WSL2:** ✅ Habilitada
- Docker funcionando nativamente no WSL2
- Containers Kubernetes disponíveis

### VS Code
**Instalação Principal (Windows via WSL2):**
```bash
/mnt/c/Users/valor/AppData/Local/Programs/Microsoft VS Code/
```

**Configurações:**
```bash
/mnt/c/Users/valor/AppData/Roaming/Code/User/settings.json
/mnt/c/Users/valor/AppData/Roaming/Code/User/keybindings.json
/mnt/c/Users/valor/.vscode
/mnt/c/Users/valor/vscode-remote-wsl
```

**Aliases Configurados:**
```bash
alias code='"/mnt/c/Users/valor/AppData/Local/Programs/Microsoft VS Code/_/Code.exe"'
alias code-version='code --version'
alias code-ext='code --list-extensions'
```

### Claude Code
**Comando:**
```bash
alias claudecode="npx @anthropic-ai/claude-code"
```

### GCC - Compilador C
**Versão:** `13.3.0` ✅

**Aliases Configurados:**
```bash
# Desenvolvimento/debugging - com warnings e debug info
alias gccdev="gcc -Wall -Wextra -g -std=c99"

# Produção - com otimização
alias gccprod="gcc -Wall -Wextra -O2 -std=c99"
```

**Uso:**
```bash
# Para desenvolvimento
gccdev arquivo.c -o programa -lm

# Para produção
gccprod arquivo.c -o programa -lm
```

**Flags explicadas:**
- `-Wall -Wextra`: Warnings essenciais para debugging
- `-g`: Inclui informações de debug (para gdb)
- `-std=c99`: Padrão C99 (moderno mas estável)
- `-O0` (gccdev): Sem otimização (melhor para debug)
- `-O2` (gccprod): Otimização para produção

### Rust - Linguagem de Sistema
**Versão:** `1.89.0` ✅ Configurado

**Ferramentas:**
- **Cargo:** `1.89.0` - Gerenciador de pacotes
- **rustc:** `1.89.0` - Compilador oficial

**Aliases Configurados:**
```bash
# Desenvolvimento - build com warnings
alias rustdev="cargo build"

# Produção - release otimizado
alias rustprod="cargo build --release"

# Executar projeto
alias rustrun="cargo run"

# Testes
alias rusttest="cargo test"
```

**VSCode - Extensões Rust:**
- **rust-analyzer** `v0.3.2563` ✅ - LSP oficial
- **CodeLLDB** `v1.11.5` ✅ - Debugger LLDB

**Funcionalidades Habilitadas:**
- ✅ **Code Completion:** Autocomplete inteligente
- ✅ **Inline Type Hints:** Tipos inferidos visíveis  
- ✅ **Inline Warnings:** Avisos em tempo real
- ✅ **Inline Errors:** Erros destacados no código
- ✅ **Hover Actions:** Run, Debug, Goto Definition
- ✅ **Code Lenses:** Referencias, implementações
- ✅ **Format on Save:** Formatação automática

### Vim - Editor de Texto
**Versão:** `9.1` ✅ Configurado

**Configuração Personalizada:**
- **Tema:** `habamax` com transparência
- **Números:** Relativos + absolutos 
- **Indentação:** 4 espaços, auto-indent
- **Busca:** Case-insensitive com highlight
- **Statusline:** Personalizada com indicador de modo
- **Undo:** Persistente em `~/.vim/undodir`

**Plugins Instalados:**
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
```

**Recursos Configurados:**
- **Autocompleção:** Setas para navegar, Enter/Right para aceitar
- **Hashbangs:** `Ctrl+X H` para inserir shebangs comuns
- **Spell Check:** PT-BR + EN (desabilitado por padrão)
- **Cursor:** Personalizado por modo (linha no insert, bloco no normal)
- **Cores:** Terminal true color + 256 cores

**Atalhos Personalizados:**
```vim
" Navegação no popup de autocompletar
inoremap <expr> <up>    pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down>  pumvisible() ? '<c-n>' : '<down>'
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr>    pumvisible() ? '<c-y>' : '<cr>'

" Inserir hashbangs
imap <c-x>h <c-r>=Hashbangs()<cr>
```

### Windows Terminal ⭐
**Configurações (acessível via WSL2):**
```bash
/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
```

**Perfis Configurados:**
- **Ubuntu WSL** (Padrão) - Font: Hack Nerd Font, Tema: Ubuntu
- **Windows PowerShell** - Shell Windows padrão  
- **Git Bash** - Para operações Git no Windows

**Git Bash:**
```bash
# Caminho Windows acessível via WSL2
/mnt/c/Programação/Git/bin/bash.exe
```

**Atalhos Principais:**
```
Ctrl+C/V        - Copiar/Colar
Ctrl+Shift+F    - Buscar  
Alt+Enter       - Tela cheia
Alt+Shift+D     - Dividir painel
Ctrl+Tab        - Próxima aba
```

---

## 🐧 Estrutura WSL2

### Acesso ao Sistema de Arquivos
```bash
# Acesso Windows → WSL2
\\wsl.localhost\Ubuntu\

# Acesso WSL2 → Windows
/mnt/c/  # Drive C:
/mnt/d/  # Drive D: (se existir)
```

### Versões das Ferramentas
- **Git (WSL):** `2.43.0`
- **Git Bash (Windows):** `GNU bash 5.2.37`
- **Node.js:** `v22.15.0`
- **NPM:** `10.9.2`
- **Docker:** `28.3.2`
- **Kernel WSL:** `6.6.87.2-microsoft-standard-WSL2`
- **GCC:** `13.3.0` ✅ 
- **Meson:** `1.3.2` ✅
- **Ninja:** `1.11.1` ✅
- **Rust:** `1.89.0` ✅
- **Cargo:** `1.89.0` ✅

---

## 📁 Estrutura do Workspace

### Organização Principal
```bash
/home/joao/workspace/
├── 📚 learning/              # Projetos de Aprendizado
│   ├── material_estudo/      # Documentação estruturada
│   │   ├── DD-MM/           # Trabalho diário (ex: 25-07)
│   │   ├── projetos/        # Definições de projetos
│   │   ├── topicos/         # Conhecimento por tema
│   │   └── fornecedores/    # Informações de serviços
│   ├── projetos_c/          # Projetos C de aprendizado
│   └── site_wm/             # Outros projetos de estudo
├── 🚀 rodando/              # Projetos em Produção
├── 📄 *.code-workspace      # Arquivos de workspace VSCode
├── 📋 ambiente.md           # Este arquivo
└── 📖 README.md             # Documentação geral
```

### Convenções por Pasta

#### 📚 Pasta `learning/` - Aprendizado
- **Propósito**: Todos os projetos em fase de aprendizado
- **Documentação**: Rica com método texto sintético
- **Tags**: Usar tags PT-BR (`<!-- CONTEXTO:tema -->`, `<!-- BUSCA:conceito -->`)
- **Estrutura**: Sessões de aprendizado, checklists incrementais
- **Exemplos**: `projetos_c/`, `site_wm/`

#### 🚀 Pasta `rodando/` - Produção
- **Propósito**: Projetos finalizados em produção
- **Documentação**: Padrão de mercado (README.md limpo)
- **Tags**: NÃO usar tags de texto sintético
- **Estrutura**: Compatível com repositórios públicos
- **Exemplos**: Projetos com deploy ativo ou repos GitHub

### Fluxo de Trabalho
```
1. Ideia → learning/material_estudo/DD-MM/
2. Desenvolvimento → learning/[projeto]/
3. Consolidação → learning/material_estudo/{projetos,topicos,fornecedores}/
4. Produção → rodando/[projeto]/
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
~/.vimrc      → /home/joao/config/vimrc         # ✅ Adicionado
```

#### 📁 **Arquivos Windows Separados**
| Arquivo Config | Caminho Windows (via WSL2) | Status |
|----------------|---------------------------|--------|
| `vscode-settings.json` | `/mnt/c/Users/valor/AppData/Roaming/Code/User/settings.json` | Cópia separada |
| `vscode-keybindings.json` | `/mnt/c/Users/valor/AppData/Roaming/Code/User/keybindings.json` | Cópia separada |
| `windows-terminal-settings.json` | `/mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json` | Cópia separada |

### 🔗 Integração Windows
```bash
# AWS & Azure (Compartilhados com Windows)
~/.aws   → /mnt/c/Users/valor/.aws/
~/.azure → /mnt/c/Users/valor/.azure/
```

### 🎨 Shell Configuration
- **Shell Padrão:** Zsh com Oh My Zsh
- **Tema:** Powerlevel10k
- **Plugins:** git, zsh-autosuggestions, z, zsh-syntax-highlighting, zsh-autocomplete
- **FZF:** Habilitado com otimizações WSL

### 📝 PATH Otimizado
```bash
# PATH limpo e sem duplicações
$HOME/.local/bin
$HOME/.npm-global/bin
# ... paths padrão do sistema
```

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

# Verificar links simbólicos
ls -la ~/.bashrc ~/.gitconfig ~/.fzf.zsh ~/.vimrc

# Verificar configuração do Vim
vim -c ':version' -c 'q' 2>/dev/null || echo "Vim configurado ✅"

# PATH atual (primeiras 10 entradas)
echo $PATH | tr ':' '\n' | head -10
```

### Recarregar Configurações
```bash
# Recarregar ZSH
source ~/.zshrc

# Recarregar perfil completo
exec zsh
```

### Git Configuration
```bash
# Configurar informações pessoais
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"

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

**5. Git Bash não funcionando no Windows Terminal:**
```bash
# Verificar se o caminho está correto
# Caminho correto: /mnt/c/Programação/Git/bin/bash.exe
# Status: ✅ Corrigido na configuração atual
```

### Arquivos de Log
```bash
# Histórico ZSH
~/.zsh_history

# Logs SSH
~/.ssh/

# Cache e temporários
~/.cache/
```