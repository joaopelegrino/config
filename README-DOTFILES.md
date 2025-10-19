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
- **bat** - cat replacement com syntax highlighting
- **lsd** - ls replacement com ícones
- **ripgrep** - grep rápido
- **fd** - find melhorado
- **bottom** - top/htop moderno
- **dust** - du visual
- **git-delta** - git diff melhor
- **zoxide** - cd inteligente (aprende seus caminhos)
- **starship** - prompt customizável

### Via scripts
- **mise** - gerenciador de ferramentas e versões
- **fzf** - fuzzy finder
- **starship** - cross-shell prompt

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

## 📚 Referências

- [chezmoi Documentation](https://www.chezmoi.io/)
- [mise Documentation](https://mise.jdx.dev/)
- [Starship Documentation](https://starship.rs/)

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

**Autor:** João Pelegrino ([@joaopelegrino](https://github.com/joaopelegrino))
**Versão:** 2.0
**Última atualização:** 2025-10-19
