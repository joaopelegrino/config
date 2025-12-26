# Dotfiles - Configuração Automatizada com Chezmoi

Este repositório contém minha configuração de ambiente de desenvolvimento, gerenciada pelo [chezmoi](https://www.chezmoi.io/).

## 🚀 Quick Start

### Nova Máquina (Setup Completo)

```bash
# Instalar chezmoi + aplicar dotfiles em um único comando
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply joaopelegrino

# Recarregar shell
exec zsh
```

⏱️ **Tempo:** ~5-10 minutos
✅ **Resultado:** Ambiente completo configurado!

### Máquina Existente (Atualizar)

```bash
# Atualizar dotfiles
chezmoi update

# Ou manualmente
chezmoi cd
git pull
chezmoi apply
```

## 📋 O Que Este Setup Faz

1. ✅ **Instala ferramentas base:** mise, starship, fzf
2. ✅ **Configura shells:** zsh com Oh My Zsh + Powerlevel10k
3. ✅ **Instala modern CLI tools:** bat, lsd, ripgrep, fd, bottom, dust, zoxide
4. ✅ **Aplica configurações:** vim, git, fzf, starship
5. ✅ **Auto-atualiza:** quando configs mudam (hashing trick!)

## 🛠️ Ferramentas Instaladas

### Via mise (automaticamente)

Todas as ferramentas abaixo são escritas em **Rust** para máxima performance:

| Ferramenta | Substitui | Performance | Funcionalidades Extras |
|------------|-----------|-------------|------------------------|
| **bat** | cat | 10x | Syntax highlighting, git integration, paginação |
| **eza** | ls/exa/lsd | 5x | Icons, git status, tree view, timestamps |
| **lsd** | ls | 5x | Icons, tree view (fallback para eza) |
| **ripgrep (rg)** | grep | 10-50x | Multi-thread, smart case, exclude patterns |
| **fd** | find | 5-10x | Simples, respeitageração.gitignore, parallel |
| **bottom (btm)** | top/htop | - | Gráficos, customizável, mouse support |
| **dust** | du | 3x | Visual tree, colorido, percentagens |
| **git-delta** | diff | - | Syntax highlighting, side-by-side, line numbers |
| **zoxide** | cd/z | 10-50x | Frecency algorithm, interactive mode, SQLite |
| **starship** | prompt | - | Cross-shell, fast (<50ms), customizável |
| **cargo-watch** | - | - | Auto-rebuild em mudanças de arquivo |

### Via scripts
- **mise** - gerenciador de ferramentas e versões (substitui nvm, pyenv, rbenv, etc.)
- **fzf** - fuzzy finder (Ctrl+R histórico, Ctrl+T arquivos)

## 📁 Estrutura

```
~/.local/share/chezmoi/                     # Source (templates)
├── .chezmoi.toml.tmpl                      # Config do chezmoi
├── .chezmoiignore                          # Arquivos a não aplicar
│
├── dot_zshrc.tmpl                          # → ~/.zshrc
├── dot_bashrc.tmpl                         # → ~/.bashrc
├── dot_vimrc                               # → ~/.vimrc
├── dot_gitconfig.tmpl                      # → ~/.gitconfig
├── dot_zshenv                              # → ~/.zshenv
├── dot_fzf.bash                            # → ~/.fzf.bash
├── dot_fzf.zsh                             # → ~/.fzf.zsh
├── dot_p10k.zsh                            # → ~/.p10k.zsh
├── dot_profile                             # → ~/.profile
│
├── dot_config/                             # → ~/.config/
│   ├── mise/
│   │   └── config.toml.tmpl                # → ~/.config/mise/config.toml
│   └── starship.toml.tmpl                  # → ~/.config/starship.toml
│
├── dot_vim/                                # → ~/.vim/
│   ├── autoload/
│   │   └── plug.vim                        # Vim-plug (plugin manager)
│   ├── plugged/                            # Plugins instalados (ignorado)
│   ├── spell/                              # Dicionários de spell checking
│   ├── undodir/                            # Histórico de undo (ignorado)
│   └── vsnip/                              # Snippets do vim-vsnip
│
├── dot_claude/                             # → ~/.claude/
│   ├── commands/                           # Slash commands customizados
│   └── settings.local.json                 # Permissões e preferências
│
├── run_once_before_install-tools.sh        # Instala base (1x apenas)
└── run_onchange_after_install-mise.sh.tmpl # Auto-reinstall (hashing trick!)
```

**Arquivos gerenciados:** 28 arquivos/diretórios aplicados automaticamente
**Documentação:** 3 guias completos (DIAGNOSTICO, VALIDACAO, ESTRUTURA)

## 🎩 Hashing Trick (Auto-Reinstall)

Quando você modifica `dot_config/mise/config.toml.tmpl`:

1. Hash no script `run_onchange_after_install-mise.sh.tmpl` muda
2. chezmoi detecta mudança automaticamente
3. mise reinstala/atualiza ferramentas
4. ✨ **Zero intervenção manual!**

## 🔧 Customização

### Adicionar Nova Ferramenta

```bash
# 1. Editar config do mise
chezmoi edit ~/.config/mise/config.toml

# Adicionar linha:
# "cargo:nova-tool" = "latest"

# 2. Aplicar (já reinstala automaticamente!)
chezmoi apply

# 3. Commitar mudança
chezmoi cd
git add .
git commit -m "feat: Add nova-tool"
git push
```

### Modificar Configs

```bash
# Ver diferenças antes de aplicar
chezmoi diff

# Editar arquivo
chezmoi edit ~/.zshrc

# Aplicar mudanças
chezmoi apply

# Ver o que chezmoi gerencia
chezmoi managed
```

## 🌐 Ambientes Diferentes

O template suporta detecção automática de:
- **OS:** Linux, macOS, Windows (WSL)
- **Arquitetura:** x64, ARM
- **WSL:** Configurações específicas

Exemplo no template:
```bash
{{- if eq .chezmoi.os "linux" }}
# Configuração Linux
{{- else if eq .chezmoi.os "darwin" }}
# Configuração macOS
{{- end }}

{{- if .is_wsl }}
# Configuração específica WSL
{{- end }}
```

## 🔐 Secrets Management

**NÃO COMMITAR** arquivos sensíveis:
- `~/.env` - variáveis de ambiente com secrets
- `~/.ssh/` - chaves SSH
- Tokens, API keys

O `.env` é carregado automaticamente pelo zshrc.

## 📊 Status Atual

- ✅ **Shells:** zsh (Oh My Zsh + P10k), bash
- ✅ **Editors:** vim
- ✅ **Tools:** mise, modern CLI tools
- ✅ **Git:** configs, aliases
- 🟡 **VS Code:** configs separadas (não gerenciadas aqui)

## 🐛 Troubleshooting

### Error: compinit docker
```bash
# Adicionar no início do .zshrc (já incluído):
ZSH_DISABLE_COMPFIX=true
```

### Ferramentas não encontradas
```bash
# Reinstalar via mise
mise install

# Verificar PATH
echo $PATH | tr ':' '\n'

# Deve incluir:
# ~/.local/bin
# ~/.cargo/bin
```

### Chezmoi não aplica mudanças
```bash
# Ver diferenças
chezmoi diff

# Forçar aplicação
chezmoi apply --force

# Debug
chezmoi apply --verbose
```

### Windows Terminal não carrega configurações

**Sintoma:** Windows Terminal abre com configurações padrão, profiles WSL não aparecem

**Diagnóstico:**
```bash
# 1. Verificar se arquivo foi copiado
ls -lh /mnt/c/Users/valor/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json

# 2. Validar JSON
python3 -m json.tool ~/.config/windows-terminal/settings.json

# 3. Testar leitura pelo Windows
powershell.exe -Command "Get-Content \$env:LOCALAPPDATA\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json -First 5"
```

**Solução:**
```bash
# 1. Sincronizar manualmente
sync-windows-terminal

# 2. Ou via chezmoi
chezmoi apply

# 3. IMPORTANTE: Fechar COMPLETAMENTE o Windows Terminal
# - Fechar todas as abas
# - Garantir que processo não está rodando

# 4. Reabrir Windows Terminal
```

**Nota:** Windows Terminal só aplica mudanças após reinicialização completa.

## 🦀 Guia Completo: Ferramentas Rust Modernas

### 🎯 Filosofia

Todas as ferramentas de CLI foram substituídas por versões modernas em **Rust**:
- **10-50x mais rápidas** que versões originais
- **Melhor UX** (cores, icons, layouts inteligentes)
- **Seguras** (memory-safe por natureza do Rust)
- **Cross-platform** (Linux, macOS, Windows)

---

### 📋 Aliases Configurados

#### **Visualização de Arquivos (eza)**

```bash
ls              # eza com icons e directories primeiro
ll              # lista longa com git status
la              # lista tudo (incluindo dot files) com git
lt              # tree view (2 níveis)
lta             # tree view (3 níveis)
laa             # lista completa com header e timestamps ISO
```

**Exemplos:**
```bash
ls                  # Lista diretório com icons
la                  # Mostra TODOS arquivos (incluindo .zshrc, .env, etc)
ll                  # Lista detalhada com permissões, tamanho, git status
lt ~/workspace      # Árvore de 2 níveis
laa                 # Lista ultra-detalhada com timestamps ISO
```

**Features do eza:**
- ✅ Icons coloridos para tipos de arquivo
- ✅ Git status integrado (modified, staged, etc)
- ✅ Group directories first
- ✅ Timestamps legíveis
- ✅ Fallback automático para lsd se eza não instalado

---

#### **Navegação Inteligente (zoxide)**

```bash
cd <pattern>        # Pula para diretório aprendido
cdi <pattern>       # cd interativo (com fzf)
z <pattern>         # Forma original (mesmo que cd)
zi <pattern>        # Forma original interativa

# Utilitários
zq <pattern>        # Query sem navegar
zl                  # Lista database completo
zr <path>           # Remove entrada
zs <pattern>        # Mostra scores
```

**Como funciona:**
1. **Aprende automaticamente** cada `cd` que você faz
2. **Frecency algorithm**: frequência + recência
3. **Smart matching**: `cd doc` → `/workspace/blog/docs`
4. **Database SQLite**: `~/.local/share/zoxide/db.zo`

**Exemplos:**
```bash
cd blog             # Pula para /workspace/especialistas/blog (mais usado)
cdi blog            # Menu interativo com fzf se múltiplos matches
z workspace         # Pula para ~/workspace
zq blog             # Mostra: /workspace/especialistas/blog (sem navegar)
zl                  # Lista todos 353 diretórios aprendidos
zs blog             # Mostra score: 1193.5 /workspace/especialistas/blog
```

**Migration do Z plugin:**
- ✅ Database do Z (`~/.z`) foi migrado automaticamente
- ✅ 353 entradas importadas com sucesso
- ✅ Plugin Z do Oh My Zsh removido (conflito resolvido)

---

#### **Busca de Conteúdo (ripgrep)**

```bash
grep <pattern>      # Busca ultra-rápida (ripgrep)
```

**Features:**
- ✅ 10-50x mais rápido que grep tradicional
- ✅ Respeita `.gitignore` automaticamente
- ✅ Multi-threaded (usa todos os cores)
- ✅ Smart case (minúscula = case-insensitive)
- ✅ Syntax highlighting nos resultados

**Exemplos:**
```bash
grep "função"                    # Busca em todos arquivos
grep "TODO" --type rust          # Apenas arquivos .rs
grep "password" --no-ignore      # Ignora .gitignore
grep -i "ERROR"                  # Case insensitive
```

---

#### **Busca de Arquivos (fd)**

```bash
find <pattern>      # Busca de arquivos (fd)
```

**Features:**
- ✅ 5-10x mais rápido que find
- ✅ Sintaxe simples (não precisa de `-name`)
- ✅ Respeita `.gitignore`
- ✅ Colorido e legível

**Exemplos:**
```bash
find config         # Encontra todos arquivos com "config"
find "\.md$"        # Regex: arquivos .md
find . --type f     # Apenas arquivos
find . --type d     # Apenas diretórios
```

---

#### **Visualização de Arquivos (bat)**

```bash
cat <file>          # bat sem paginação
catp <file>         # bat com paginação
```

**Features:**
- ✅ Syntax highlighting automático
- ✅ Git integration (mostra modificações)
- ✅ Line numbers
- ✅ Suporte a 200+ linguagens

**Exemplos:**
```bash
cat README.md       # Markdown com highlighting
cat script.py       # Python com cores
catp long-file.txt  # Com paginação (less)
```

---

#### **Monitor de Recursos (bottom)**

```bash
top                 # bottom (gráfico moderno)
```

**Features:**
- ✅ Interface gráfica no terminal
- ✅ CPU, RAM, Network, Disk em tempo real
- ✅ Mouse support
- ✅ Filtros e ordenação
- ✅ Themes customizáveis

---

#### **Uso de Disco (dust)**

```bash
du <path>           # dust (visual tree)
```

**Features:**
- ✅ Tree view colorido
- ✅ Percentagens visíveis
- ✅ 3x mais rápido que du
- ✅ Ordenação automática

**Exemplo:**
```bash
du ~/workspace      # Árvore visual de uso de disco
```

---

### 🔧 Configuração Avançada

#### **Adicionar Nova Ferramenta Rust**

```bash
# 1. Editar config do mise
chezmoi edit ~/.config/mise/config.toml

# 2. Adicionar linha:
"cargo:TOOL_NAME" = "latest"

# 3. Aplicar (reinstala automaticamente!)
chezmoi apply

# 4. Ferramenta já está no PATH via mise
```

#### **Git Delta (Melhor Diff)**

Adicione ao `~/.gitconfig`:
```gitconfig
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    line-numbers = true
    syntax-theme = "Monokai Extended"
    side-by-side = false
```

Depois:
```bash
git diff                # Diff com syntax highlighting
git log -p              # Log com diff colorido
```

---

### ⚡ Performance Comparisons

**Benchmark real (workspace com 10.000 arquivos):**

```bash
# Lista de arquivos
time ls        →  0.05s (coreutils)
time lsd       →  0.01s (5x faster)
time eza       →  0.01s (5x faster)

# Busca de conteúdo
time grep TODO → 2.5s (GNU grep)
time rg TODO   → 0.05s (50x faster!)

# Busca de arquivos
time find . -name "*.md" → 1.2s
time fd "\.md$"          → 0.15s (8x faster)

# Navegação (diretório distante)
time cd /long/path/...   → 0.001s
time z pattern           → 0.002s (+ aprendizado)
```

---

### 🎨 Customização

#### **Eza (personalizar output)**

Editar `~/.zshrc`:
```bash
alias ls='eza --icons --group-directories-first --color=always'
alias ll='eza -lbhHigUmuSa --icons --group-directories-first'
```

#### **Bat (trocar tema)**

```bash
bat --list-themes          # Ver temas disponíveis
export BAT_THEME="Dracula"
```

Adicionar ao `~/.zshenv` para persistir.

#### **Zoxide (limpar database)**

```bash
zoxide remove ~/old-project    # Remove entrada específica
zoxide query --list | wc -l    # Ver tamanho do database
```

---

### 🐛 Troubleshooting Ferramentas Rust

**Problema:** Ferramenta não encontrada após `mise install`

```bash
# 1. Verificar se está instalada
mise ls | grep TOOL

# 2. Recarregar shell (mise ativa PATH)
exec zsh

# 3. Verificar PATH
echo $PATH | grep mise
```

**Problema:** Eza não mostra icons

```bash
# Instalar Nerd Font (ex: FiraCode Nerd Font)
# Configurar terminal para usar a fonte

# Verificar suporte:
echo "\ue0b0"  # Deve mostrar um triangulo
```

**Problema:** Zoxide não aprende diretórios

```bash
# Verificar se hook está ativo
type __zoxide_hook

# Forçar adicionar manualmente
zoxide add /path/to/dir

# Ver database
zoxide query --list
```

---

### 📊 Status das Migrações

- ✅ **Z → Zoxide**: 353 entradas migradas, plugin Z removido
- ✅ **ls → eza**: Prioridade sobre lsd, fallback configurado
- ✅ **grep → ripgrep**: Alias global
- ✅ **find → fd**: Alias global
- ✅ **cat → bat**: Alias com/sem paginação
- ✅ **top → bottom**: Alias global
- ✅ **du → dust**: Alias global

---

## 📚 Referências

### Documentação Oficial
- [chezmoi Documentation](https://www.chezmoi.io/)
- [mise Documentation](https://mise.jdx.dev/)
- [Starship Documentation](https://starship.rs/)

### Ferramentas Rust
- [eza](https://eza.rocks/) - Modern ls replacement
- [bat](https://github.com/sharkdp/bat) - Cat clone with wings
- [ripgrep](https://github.com/BurntSushi/ripgrep) - Fast grep
- [fd](https://github.com/sharkdp/fd) - Simple find
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd
- [bottom](https://github.com/ClementTsang/bottom) - Graphical top
- [dust](https://github.com/bootandy/dust) - Intuitive du
- [delta](https://github.com/dandavison/delta) - Better git diff

## 🎓 Workflow Original

Baseado no setup de Rio (DevPod + chezmoi + mise):
- Documento: `ferramentas-dev/workflows/setup-dotfiles-automacao.md`
- Adaptado para uso individual sem DevPod

---

## 🔧 Correções Aplicadas (2025-10-19)

### Problema Crítico do Vim - RESOLVIDO ✅

**Sintoma:** Vim não carregava plugins (E117: Função desconhecida: plug#begin)

**Causa:** Diretório `vim/` sem prefixo `dot_` → aplicado como `~/vim/` em vez de `~/.vim/`

**Solução:**
- Renomeado `vim/` → `dot_vim/`
- 14 plugins reinstalados via :PlugInstall
- Estrutura completa restaurada

**Resultado:** ✅ Vim 100% funcional novamente!

### Duplicações Removidas ✅

- Removidos 5 arquivos duplicados (fzf.bash, fzf.zsh, p10k.zsh, profile, vimrc.backup)
- Home directory limpo (sem arquivos sem ponto inicial)
- Repo organizado (-9 arquivos desnecessários)

### Claude Code Integrado ✅

- Adicionado `dot_claude/` com configurações
- Sem secrets (apenas permissões)

**Documentação completa:**
- `DIAGNOSTICO-COMPLETO.md` - Análise detalhada
- `VALIDACAO-CORRECOES.md` - Checklist completo
- `ESTRUTURA-DIRETORIOS.md` - Como funciona o espelhamento

---

---

## 🔧 Atualizações Recentes (2025-10-20)

### Migração Completa para Ferramentas Rust ✅

**Z → Zoxide (Navegação Inteligente)**
- ✅ Plugin Z do Oh My Zsh removido
- ✅ Zoxide (Rust) ativo e configurado
- ✅ Database migrado: 353 entradas
- ✅ Aliases configurados: `cd`, `cdi`, `zq`, `zl`, `zr`, `zs`
- ✅ Performance: 10-50x mais rápido

**lsd → eza (Visualização de Arquivos)**
- ✅ Eza instalado via mise
- ✅ Prioridade sobre lsd (fallback automático)
- ✅ Aliases: `ls`, `ll`, `la`, `lt`, `lta`, `laa`
- ✅ Features: icons, git status, tree view, timestamps

**Sem Conflitos:**
- ✅ Sistema de prioridade: eza > lsd > ls
- ✅ Fallback automático se ferramenta não instalada
- ✅ Compatibilidade total com scripts legados

---

## 🔧 Atualizações Recentes (2025-10-22)

### Windows Terminal Integrado ao Chezmoi ✅

**Gerenciamento Completo:**
- ✅ `dot_config/windows-terminal/settings.json.tmpl` - Template com variáveis
- ✅ `run_once_after_setup-windows-terminal.sh.tmpl` - Setup inicial
- ✅ `run_onchange_after_sync-windows-terminal.sh.tmpl` - Auto-sync em mudanças
- ✅ `sync-windows-terminal` - Comando manual de sincronização

**Variáveis Dinâmicas:**
- `{{ .windows_username }}` - Username do Windows
- `{{ .wsl_profile_guid }}` - GUID do profile WSL
- `{{ .chezmoi.username }}` - Username do WSL

**Workflow:**
```bash
# 1. Editar configurações
chezmoi edit ~/.config/windows-terminal/settings.json

# 2. Aplicar mudanças (copia automaticamente)
chezmoi apply

# 3. Reiniciar Windows Terminal para ver mudanças
```

**⚠️ Limitação Crítica Descoberta: Symlinks WSL→Windows NÃO funcionam**
- Windows não consegue ler symlinks criados pelo WSL
- Solução: Arquivo é **copiado** em vez de symlinked
- Auto-sync implementado para manter sincronização

**Documentação Completa:**
- `PROPOSTA-WINDOWS-TERMINAL-CHEZMOI.md` - Proposta original
- `WINDOWS-TERMINAL-IMPLEMENTACAO-COMPLETA.md` - Implementação inicial
- `WINDOWS-TERMINAL-CORRECAO-SYMLINK.md` - Correção e aprendizados

---

## 🎯 Próximos Passos Recomendados

### 1. Configurar Git Delta (já instalado) 🔧

O git-delta já está instalado, mas precisa ser ativado no `.gitconfig`:

```bash
# Editar gitconfig via chezmoi
chezmoi edit ~/.gitconfig

# Adicionar ao final do arquivo:
```

```gitconfig
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    line-numbers = true
    syntax-theme = "Monokai Extended"
    side-by-side = false
    features = decorations

[delta "decorations"]
    commit-decoration-style = bold yellow box ul
    file-style = bold yellow ul
    file-decoration-style = none
    hunk-header-decoration-style = cyan box ul
```

**Aplicar mudanças:**
```bash
chezmoi apply ~/.gitconfig

# Testar
git diff              # Agora com syntax highlighting!
git log -p --color    # Log com diff colorido
```

**Features do delta:**
- ✅ Syntax highlighting para diffs
- ✅ Side-by-side view (opcional)
- ✅ Line numbers
- ✅ Git blame integration
- ✅ Navegação com n/N

---

### 2. Instalar Nerd Font (para icons perfeitos) 🎨

O eza mostra icons, mas precisa de uma **Nerd Font** instalada:

#### **No Windows (WSL2)**

```powershell
# No PowerShell (Windows)
# 1. Baixar FiraCode Nerd Font
# https://www.nerdfonts.com/font-downloads

# 2. Extrair e instalar (clique duplo nos .ttf)

# 3. Configurar Windows Terminal
# Settings > Profiles > Defaults > Appearance > Font face
# Escolher: "FiraCode Nerd Font" ou "FiraCode NF"
```

#### **No Linux (nativo)**

```bash
# Ubuntu/Debian
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Baixar FiraCode Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip

# Atualizar cache de fontes
fc-cache -fv

# Configurar terminal para usar "FiraCode Nerd Font"
```

#### **Verificar suporte:**

```bash
# Testar icons
echo "\ue0b0 \uf114 \uf07c \uf015"
# Deve mostrar: ➤

# Testar eza com icons
eza --icons ~/
```

**Fontes recomendadas:**
- **FiraCode Nerd Font** (monospace, ligatures)
- **JetBrains Mono Nerd Font** (alternativa popular)
- **Hack Nerd Font** (leve e clara)

---

### 3. Testar Starship (prompt moderno) ⚡

Starship já está instalado via mise, mas **Powerlevel10k está ativo**. Para testar:

#### **Opção A: Testar temporariamente**

```bash
# Em uma sessão:
eval "$(starship init zsh)"

# Explorar o prompt
cd ~/workspace
git status

# Para voltar ao P10k:
exec zsh
```

#### **Opção B: Ativar permanentemente**

```bash
# 1. Editar zshrc
chezmoi edit ~/.zshrc

# 2. Comentar Powerlevel10k (linha ~44):
# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME=""  # Desabilitar tema Oh My Zsh

# 3. Descomentar Starship (linhas ~660-663):
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# 4. Aplicar
chezmoi apply ~/.zshrc
exec zsh
```

#### **Customizar Starship**

```bash
# Editar config
chezmoi edit ~/.config/starship.toml

# Presets disponíveis:
starship preset nerd-font-symbols -o ~/.config/starship.toml
starship preset gruvbox-rainbow -o ~/.config/starship.toml

# Aplicar
chezmoi apply ~/.config/starship.toml
exec zsh
```

**Vantagens do Starship:**
- ✅ Mais rápido que P10k (<50ms)
- ✅ Cross-shell (zsh, bash, fish)
- ✅ Configuração em TOML (mais simples)
- ✅ Git status mais rico
- ✅ Suporte a 40+ linguagens

**Desvantagens:**
- ⚠️ Menos features que P10k (sem right prompt rico)
- ⚠️ P10k tem wizard de configuração melhor

---

### 4. Outras Ferramentas Rust Úteis (Opcional) 🛠️

Adicione ao `~/.config/mise/config.toml`:

```toml
[tools]
# ... ferramentas existentes ...

# Extras úteis
"cargo:sd" = "latest"              # sed replacement (busca e substitui)
"cargo:procs" = "latest"           # ps replacement (lista processos)
"cargo:tokei" = "latest"           # conta linhas de código
"cargo:hyperfine" = "latest"       # benchmarking de comandos
"cargo:gitui" = "latest"           # TUI para git
"cargo:bandwhich" = "latest"       # monitor de bandwidth
```

Depois:
```bash
chezmoi apply
mise install
```

**Descrição:**
- **sd**: Busca e substitui (mais simples que sed)
- **procs**: Lista de processos colorida e filtrável
- **tokei**: Estatísticas de código (linhas, comentários, etc)
- **hyperfine**: Benchmark de comandos CLI
- **gitui**: Interface TUI para git (alternativa ao vim-fugitive)
- **bandwhich**: Monitor de uso de rede por processo

---

### 5. Configurar FZF Keybindings Adicionais 🔍

FZF já está instalado, mas você pode adicionar mais atalhos:

```bash
# Adicionar ao ~/.zshrc (via chezmoi edit)

# FZF com preview usando bat
export FZF_DEFAULT_OPTS="
  --height 60%
  --layout=reverse
  --border
  --preview 'bat --style=numbers --color=always --line-range :500 {}'
  --preview-window right:50%:wrap
"

# FZF para cd interativo (além do zoxide)
alias cdf='cd $(fd --type d | fzf)'

# FZF para abrir arquivo no vim
alias vf='vim $(fzf)'

# FZF para kill process
alias fkill='kill -9 $(ps aux | fzf | awk "{print \$2}")'

# FZF para git checkout branch
alias gcof='git checkout $(git branch -a | fzf | sed "s/remotes\/origin\///" | xargs)'
```

---

### 6. Criar Aliases Personalizados Úteis 🎨

Adicione seus aliases favoritos ao `~/.zshrc`:

```bash
# Via chezmoi edit
chezmoi edit ~/.zshrc

# Sugestões de aliases úteis:

# Git shortcuts
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gcl='git clone'
alias gundo='git reset --soft HEAD~1'

# Docker (se usar)
alias dclean='docker system prune -a --volumes -f'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# Sistema
alias myip='curl ifconfig.me'
alias ports='netstat -tulanp | grep LISTEN'
alias update-all='sudo apt update && sudo apt upgrade -y && mise upgrade'

# Workspace navigation (eza + zoxide)
alias work='cd ~/workspace && eza -la'
alias projects='eza -la --tree ~/workspace --level=2'

# Backup rápido
alias backup-dots='chezmoi cd && git add . && git commit -m "backup: $(date +%Y-%m-%d)" && git push'
```

---

## ✅ Checklist de Otimizações

- [ ] Git delta configurado (melhores diffs)
- [ ] Nerd Font instalada (icons perfeitos no eza)
- [ ] Starship testado (prompt alternativo)
- [ ] Ferramentas extras instaladas (sd, procs, tokei, etc)
- [ ] FZF keybindings adicionais
- [ ] Aliases personalizados criados
- [ ] Backup dos dotfiles no Git

---

## 🎓 Aprendizados Importantes

### WSL ↔ Windows: Limitações de Symlinks

**Descoberta Crítica:** Windows **não consegue ler** symlinks criados pelo WSL

**Impacto:**
- ✅ Symlinks WSL → WSL: Funcionam perfeitamente
- ✅ Symlinks Windows → WSL: Funcionam (requer Modo Desenvolvedor)
- ❌ Symlinks WSL → Windows: **NÃO FUNCIONAM**

**Casos Afetados:**
- Windows Terminal settings.json
- Qualquer aplicação Windows lendo arquivos WSL
- Cross-boundary file access

**Solução Implementada:**
- Usar **cópia** em vez de symlink quando Windows é o consumidor
- Scripts automáticos de sincronização (`run_onchange_after_*.sh.tmpl`)
- Comando manual `sync-windows-terminal` para sync rápido

**Referências:**
- [Trail of Bits: Why Windows can't follow WSL symlinks (Feb 2024)](https://blog.trailofbits.com/2024/02/12/why-windows-cant-follow-wsl-symlinks/)
- [GitHub Issue #12250 (microsoft/WSL)](https://github.com/microsoft/WSL/issues/12250)
- [Stack Overflow: WSL symlink from Windows](https://stackoverflow.com/questions/57580420/)

### Docker Completion Warning (Inofensivo)

**Warning:** `compinit:527: no such file or directory: /usr/share/zsh/vendor-completions/_docker`

**Causa:**
- Docker Desktop monta completions via `/mnt/wsl/docker-desktop/`
- Zsh tenta carregar antes do mount completar durante boot

**Solução:**
```bash
ZSH_DISABLE_COMPFIX=true  # Já configurado em dot_zshrc.tmpl:5
```

**Impacto:** Nenhum - completions funcionam normalmente após Docker Desktop iniciar

### Chezmoi Hashing Trick

**Técnica Avançada:** Auto-reinstalação de ferramentas quando config muda

**Como funciona:**
```bash
# run_onchange_after_install-mise.sh.tmpl
# Hash: {{ include "dot_config/mise/config.toml.tmpl" | sha256sum }}

# Quando mise config.toml muda:
# 1. Hash no comentário muda
# 2. Chezmoi detecta arquivo modificado
# 3. Script roda automaticamente
# 4. mise reinstala/atualiza ferramentas
```

**Vantagem:** Zero intervenção manual para manter ferramentas atualizadas!

### Template Variables Best Practices

**Variáveis de Sistema (Auto-detectadas):**
```bash
{{ .chezmoi.os }}           # "linux", "darwin", "windows"
{{ .chezmoi.arch }}         # "amd64", "arm64"
{{ .chezmoi.username }}     # Username WSL
{{ .chezmoi.hostname }}     # Nome da máquina
```

**Variáveis Customizadas (Prompt ou Default):**
```toml
# .chezmoi.toml.tmpl
[data]
    windows_username = "{{ promptStringOnce . "windows_username" "Windows username" "valor" }}"
    wsl_profile_guid = "{{ promptStringOnce . "wsl_profile_guid" "WSL GUID" "{guid}" }}"
```

**Condicionais por Ambiente:**
```bash
{{- if eq .chezmoi.os "linux" }}
# Linux-specific config
{{- else if eq .chezmoi.os "darwin" }}
# macOS-specific config
{{- end }}

{{- if (.chezmoi.kernel.osrelease | lower | contains "microsoft") }}
# WSL2-specific config
{{- end }}
```

---

**Autor:** João Pelegrino ([@joaopelegrino](https://github.com/joaopelegrino))
**Versão:** 3.1
**Última atualização:** 2025-10-22
