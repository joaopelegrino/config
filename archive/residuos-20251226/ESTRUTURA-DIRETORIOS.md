# Estrutura de Diretórios - Chezmoi

## 📁 Estrutura de Espelhamento

O chezmoi usa um sistema de **source** (templates) e **target** (arquivos reais):

```
┌─────────────────────────────────────────────────────────────┐
│  SOURCE: ~/.local/share/chezmoi/                            │
│  (Repositório Git com templates)                            │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ chezmoi apply
                            ↓
┌─────────────────────────────────────────────────────────────┐
│  TARGET: ~/                                                  │
│  (Arquivos reais no home directory)                         │
└─────────────────────────────────────────────────────────────┘
```

## 🔄 Mapeamento de Arquivos

### Prefixos do Chezmoi

O chezmoi usa prefixos especiais para mapear arquivos:

| Prefixo no Source | Resultado no Target | Exemplo |
|-------------------|---------------------|---------|
| `dot_` | `.` (arquivo oculto) | `dot_zshrc` → `~/.zshrc` |
| `.tmpl` | Processa template | `dot_zshrc.tmpl` → `~/.zshrc` (com variáveis) |
| `private_` | Permissões 0600 | `private_dot_ssh/id_rsa` → `~/.ssh/id_rsa` |
| `executable_` | Permissões executáveis | `executable_script.sh` → `~/script.sh` (755) |
| `run_once_` | Script executado 1x | `run_once_setup.sh` → executa uma vez |
| `run_onchange_` | Script quando muda | `run_onchange_install.sh` → executa se mudar |

### Exemplos Práticos

```
SOURCE (Repo)                          TARGET (Home)
─────────────────────────────────────  ────────────────────────
~/.local/share/chezmoi/
├── dot_zshrc.tmpl                  →  ~/.zshrc
├── dot_bashrc.tmpl                 →  ~/.bashrc
├── dot_vimrc                       →  ~/.vimrc
├── dot_gitconfig.tmpl              →  ~/.gitconfig
├── dot_fzf.bash                    →  ~/.fzf.bash
├── dot_fzf.zsh                     →  ~/.fzf.zsh
├── dot_p10k.zsh                    →  ~/.p10k.zsh
├── dot_profile                     →  ~/.profile
│
├── dot_config/                     →  ~/.config/
│   ├── mise/
│   │   └── config.toml.tmpl        →  ~/.config/mise/config.toml
│   └── starship.toml.tmpl          →  ~/.config/starship.toml
│
├── run_once_before_install-tools.sh  → Executa UMA VEZ antes de aplicar
├── run_onchange_after_install-mise.sh.tmpl → Executa quando mise config muda
│
└── README-DOTFILES.md              →  NÃO aplicado (está em .chezmoiignore)
```

## 🗂️ Estrutura Completa Atual

```
/home/notebook/
│
├── .local/share/chezmoi/          ← REPOSITÓRIO SOURCE (Git)
│   ├── .git/                      ← Git repo (remote: github.com/joaopelegrino/config)
│   ├── .chezmoi.toml.tmpl         ← Config do chezmoi
│   ├── .chezmoiignore             ← Arquivos a não aplicar
│   │
│   ├── dot_zshrc.tmpl             ← Template do ~/.zshrc
│   ├── dot_bashrc.tmpl            ← Template do ~/.bashrc
│   ├── dot_vimrc                  ← Config do vim
│   ├── dot_gitconfig.tmpl         ← Config do git
│   ├── dot_fzf.bash               ← FZF para bash
│   ├── dot_fzf.zsh                ← FZF para zsh
│   ├── dot_p10k.zsh               ← Powerlevel10k config
│   ├── dot_profile                ← Profile shell
│   │
│   ├── dot_config/                ← ~/.config/
│   │   ├── mise/
│   │   │   └── config.toml.tmpl   ← Ferramentas do mise
│   │   └── starship.toml.tmpl     ← Starship config
│   │
│   ├── run_once_before_install-tools.sh     ← Setup inicial
│   ├── run_onchange_after_install-mise.sh.tmpl ← Hashing trick
│   │
│   ├── README-DOTFILES.md         ← Documentação completa
│   ├── GUIA-RAPIDO.md             ← Guia de uso
│   └── ESTRUTURA-DIRETORIOS.md    ← Este arquivo
│
├── .config/chezmoi/               ← CONFIG DO CHEZMOI (local)
│   └── chezmoi.toml               ← Variáveis pessoais (não commitado)
│
├── .zshrc                         ← ARQUIVO APLICADO
├── .bashrc                        ← ARQUIVO APLICADO
├── .vimrc                         ← ARQUIVO APLICADO
├── .gitconfig                     ← ARQUIVO APLICADO
├── .fzf.bash                      ← ARQUIVO APLICADO
├── .fzf.zsh                       ← ARQUIVO APLICADO
├── .p10k.zsh                      ← ARQUIVO APLICADO
├── .profile                       ← ARQUIVO APLICADO
│
├── .config/                       ← ARQUIVOS APLICADOS
│   ├── mise/
│   │   └── config.toml            ← ARQUIVO APLICADO (gerado do template)
│   └── starship.toml              ← ARQUIVO APLICADO (gerado do template)
│
└── config.backup-YYYYMMDD-HHMMSS/ ← BACKUP do repo antigo (pode deletar depois)
```

## 🚫 Repositório Antigo Removido

### Antes (Duplicado - ERRADO)

```
/home/notebook/
├── config/                        ← Repo antigo (REMOVIDO)
│   └── (symlinks para arquivos)
│
└── .local/share/chezmoi/          ← Repo chezmoi
    └── (templates)
```

### Depois (Consolidado - CORRETO)

```
/home/notebook/
└── .local/share/chezmoi/          ← ÚNICO repo (source)
    └── (templates)                   ↓ chezmoi apply
                                      ↓
    ~/                             ← Arquivos aplicados (target)
```

## 📝 Workflow de Edição

### ❌ ERRADO: Editar arquivos direto no home

```bash
vim ~/.zshrc           # ❌ Mudanças serão sobrescritas!
```

### ✅ CORRETO: Editar via chezmoi

```bash
# Opção 1: Usar chezmoi edit
chezmoi edit ~/.zshrc  # ✅ Edita o template no source

# Opção 2: Ir direto ao source
cd ~/.local/share/chezmoi
vim dot_zshrc.tmpl     # ✅ Edita o template

# Aplicar mudanças
chezmoi apply          # Aplica do source para target
```

## 🔄 Ciclo de Vida de Mudanças

```
1. EDITAR
   ↓
   chezmoi edit ~/.zshrc
   ↓
   (abre: ~/.local/share/chezmoi/dot_zshrc.tmpl)

2. VER DIFERENÇAS
   ↓
   chezmoi diff
   ↓
   (mostra diferenças entre template e arquivo aplicado)

3. APLICAR
   ↓
   chezmoi apply
   ↓
   (processa template e aplica em ~/.zshrc)

4. COMMITAR (se bom)
   ↓
   chezmoi cd
   git add dot_zshrc.tmpl
   git commit -m "feat: Update zshrc"
   git push
   exit

5. SINCRONIZAR EM OUTRA MÁQUINA
   ↓
   chezmoi update
   ↓
   (git pull + chezmoi apply automaticamente)
```

## 🎯 Templates vs Arquivos Normais

### Quando usar `.tmpl`?

**USE `.tmpl` quando:**
- Arquivo tem variáveis dinâmicas (nome, email, hostname)
- Configuração muda por OS (Linux vs macOS)
- Tem lógica condicional

**NÃO use `.tmpl` quando:**
- Arquivo é estático (mesmo em todas as máquinas)
- Sem variáveis ou condições

### Exemplos

**COM template (.tmpl):**
```toml
# dot_gitconfig.tmpl
[user]
    name = "{{ .name }}"              # Variável dinâmica
    email = "{{ .email }}"            # Variável dinâmica

{{- if eq .chezmoi.os "linux" }}
[core]
    editor = vim                       # Linux-específico
{{- else if eq .chezmoi.os "darwin" }}
[core]
    editor = code                      # macOS-específico
{{- end }}
```

**SEM template (arquivo normal):**
```bash
# dot_vimrc (sem .tmpl)
set number
set relativenumber
syntax on
" Sempre igual em todas as máquinas
```

## 🔐 Arquivos Privados

Para arquivos sensíveis (chaves SSH, tokens):

```
private_dot_ssh/
├── private_id_rsa             → ~/.ssh/id_rsa (permissões 0600)
└── private_id_rsa.pub         → ~/.ssh/id_rsa.pub (permissões 0600)
```

**Atenção:** Arquivos com `private_` ficam no repo. Para secrets reais, use:
1. `.chezmoiignore` (não commitar)
2. Encrypted files (GPG)
3. 1Password integration

## 📊 Comandos Úteis

```bash
# Ver mapeamento source → target
chezmoi managed

# Ver onde chezmoi armazena templates
chezmoi source-path ~/.zshrc
# Output: /home/notebook/.local/share/chezmoi/dot_zshrc.tmpl

# Ver arquivo aplicado (target)
chezmoi cat ~/.zshrc

# Ver diferenças
chezmoi diff

# Ir para diretório source
chezmoi cd
# (você está em ~/.local/share/chezmoi)
pwd
# /home/notebook/.local/share/chezmoi

# Voltar
exit
```

## 🎓 Resumo

**Source (Templates):** `~/.local/share/chezmoi/` (Git repo)
**Target (Arquivos):** `~/` (arquivos aplicados)
**Config local:** `~/.config/chezmoi/chezmoi.toml`

**Regra de Ouro:**
1. SEMPRE edite via `chezmoi edit`
2. NUNCA edite arquivos direto no home (serão sobrescritos)
3. Use `chezmoi diff` antes de `chezmoi apply`
4. Commite mudanças no source para sincronizar

---

**Documentação oficial:** https://www.chezmoi.io/
