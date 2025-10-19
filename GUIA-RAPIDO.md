# Guia Rápido - Dotfiles com Chezmoi

## ✅ Setup Completo!

Seu ambiente foi configurado com sucesso! Aqui está um resumo do que foi instalado e como usar.

## 🎯 O Que Foi Instalado

### Ferramentas Base
- ✅ **chezmoi** - Gerenciador de dotfiles
- ✅ **mise** - Gerenciador de ferramentas e versões
- ✅ **starship** - Prompt cross-shell moderno
- ✅ **fzf** - Fuzzy finder
- ✅ **Rust** - Toolchain completo (rustc, cargo)

### Modern CLI Tools (via mise + cargo)
- ✅ **bat** - `cat` com syntax highlighting
- ✅ **lsd** - `ls` com ícones e cores
- ✅ **ripgrep** - `grep` super rápido
- ✅ **fd** - `find` melhorado
- ✅ **bottom** - `top/htop` moderno
- ✅ **dust** - `du` visual
- ✅ **git-delta** - git diff melhorado
- ✅ **zoxide** - `cd` inteligente que aprende

## 🚀 Comandos Úteis

### Chezmoi (Gerenciamento de Dotfiles)

```bash
# Ver o que chezmoi está gerenciando
chezmoi managed

# Ver diferenças entre templates e arquivos aplicados
chezmoi diff

# Editar arquivo gerenciado
chezmoi edit ~/.zshrc

# Aplicar mudanças
chezmoi apply

# Atualizar dotfiles (git pull + apply)
chezmoi update

# Ir para o diretório do chezmoi
chezmoi cd
# (dentro dele você pode usar git normalmente)

# Voltar
exit
```

### mise (Gerenciamento de Ferramentas)

```bash
# Listar ferramentas instaladas
mise list

# Instalar todas as ferramentas do config
mise install

# Instalar ferramenta específica
mise install cargo:bat

# Atualizar todas as ferramentas
mise upgrade

# Ver ferramentas disponíveis
mise plugins
```

## 📝 Workflow de Atualização

### 1. Adicionar Nova Ferramenta

```bash
# 1. Editar config do mise
chezmoi edit ~/.config/mise/config.toml

# Adicionar no [tools]:
# "cargo:exa" = "latest"  # exemplo

# 2. Aplicar (já reinstala automaticamente via hashing trick!)
chezmoi apply

# 3. Verificar instalação
mise list

# 4. Commitar mudança
chezmoi cd
git add dot_config/mise/config.toml.tmpl
git commit -m "feat: Add exa tool"
git push
exit
```

### 2. Modificar Configuração do Shell

```bash
# 1. Editar zshrc
chezmoi edit ~/.zshrc

# 2. Ver diferenças
chezmoi diff

# 3. Aplicar
chezmoi apply

# 4. Recarregar shell
exec zsh

# 5. Se estiver bom, commitar
chezmoi cd
git add dot_zshrc.tmpl
git commit -m "feat: Add new aliases"
git push
exit
```

### 3. Sincronizar em Outra Máquina

```bash
# Atualizar dotfiles
chezmoi update

# Isso faz:
# - git pull do seu repo
# - Re-aplica templates
# - Re-executa scripts se configs mudaram (hashing trick)
# - mise reinstala/atualiza ferramentas automaticamente
```

## 🎩 Hashing Trick (A Mágica!)

Quando você edita `~/.config/mise/config.toml` via chezmoi:

1. O hash no script `run_onchange_after_install-mise.sh` muda
2. chezmoi detecta que o script mudou
3. Script é re-executado automaticamente
4. mise reinstala/atualiza ferramentas
5. ✨ **Zero intervenção manual!**

## 🔧 Aliases Automáticos

Quando as ferramentas estiverem instaladas, estes aliases estarão disponíveis:

```bash
# Modern CLI replacements
cat   → bat        # cat com syntax highlighting
ls    → lsd        # ls com ícones
grep  → rg         # grep rápido
find  → fd         # find melhorado
top   → btm        # top moderno
du    → dust       # du visual
cd    → z          # cd inteligente (zoxide)
```

Para usar os comandos originais, use:

```bash
\cat arquivo.txt   # comando original
/bin/ls            # comando original
```

## 📊 Verificar Status

```bash
# Ver ferramentas instaladas
mise list

# Ver versões
bat --version
lsd --version
rg --version

# Verificar se aliases estão ativos
type cat    # deve mostrar: cat is an alias for bat
type ls     # deve mostrar: ls is an alias for lsd
```

## 🐛 Troubleshooting

### Ferramenta não encontrada

```bash
# Reinstalar via mise
mise install

# Verificar PATH
echo $PATH

# Deve incluir ~/.cargo/bin
```

### Aliases não funcionam

```bash
# Recarregar shell
exec zsh

# Verificar se mise está ativado
which bat lsd rg

# Se não encontrar, ativar mise manualmente
eval "$(~/.local/bin/mise activate zsh)"
```

### Chezmoi não aplica mudanças

```bash
# Forçar aplicação
chezmoi apply --force

# Ver o que vai mudar
chezmoi diff

# Debug
chezmoi apply --verbose
```

## 🌐 Setup em Nova Máquina

Para replicar este ambiente em qualquer máquina:

```bash
# Um único comando!
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply joaopelegrino

# Aguardar instalação (~5-10 minutos)

# Recarregar shell
exec zsh

# Pronto! Ambiente idêntico configurado.
```

## 📁 Arquivos Importantes

```
~/.local/share/chezmoi/          # Repo dos dotfiles
~/.config/chezmoi/chezmoi.toml   # Config do chezmoi (suas preferências)
~/.config/mise/config.toml       # Config do mise (ferramentas)
~/.zshrc                         # Shell config (gerenciado)
~/.local/bin/                    # Binários do mise e ferramentas
~/.cargo/bin/                    # Binários Rust/cargo
```

## 🔐 Segurança

**NÃO COMMITAR:**
- `~/.env` - variáveis de ambiente sensíveis
- `~/.ssh/` - chaves SSH
- Tokens, API keys, senhas

Estes arquivos são carregados automaticamente mas não gerenciados pelo chezmoi.

## 📚 Próximos Passos

1. ✅ Explorar as ferramentas instaladas:
   ```bash
   bat README.md      # cat com syntax highlighting
   lsd -la            # ls com ícones
   rg "pattern"       # busca rápida
   ```

2. ✅ Customizar seu prompt:
   ```bash
   # Editar starship config
   chezmoi edit ~/.config/starship.toml
   ```

3. ✅ Adicionar mais ferramentas ao mise:
   ```bash
   chezmoi edit ~/.config/mise/config.toml
   ```

4. ✅ Explorar comandos do zoxide:
   ```bash
   z project     # pula para diretório que contém "project"
   zi            # interface interativa de seleção
   ```

---

**Dica:** Use `chezmoi diff` antes de aplicar mudanças para ver exatamente o que vai mudar!

**Lembre-se:** Toda vez que você edita configs via `chezmoi edit`, faça `chezmoi apply` depois!
