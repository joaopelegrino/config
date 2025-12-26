# Claude Code + Vim/Terminal: Guia de Integração e Boas Práticas

## Introdução

Este guia aborda problemas conhecidos, limitações e boas práticas para usar Claude Code em diferentes contextos de terminal, especialmente com Vim e aplicações interativas. Baseado em pesquisa da documentação oficial, issues do GitHub e experiências da comunidade.

## ⚠️ Problemas Conhecidos e Limitações

### 1. Problemas em Terminais Comuns (WSL2/Windows Terminal)

#### Issues Críticas

**Terminal State Corruption (Issue #5671)**
- **Problema**: Durante comandos como `/memory`, o estado do terminal fica corrompido
- **Sintomas**: Interface TUI "vaza" através da tela, elementos fora do lugar
- **Workaround**: Reiniciar sessão Claude Code, usar `Ctrl+C` para cancelar

**Responsividade Intermitente (Issue #619)**
- **Problema**: Claude CLI para de responder aleatoriamente durante o uso
- **Sintomas**: Processo roda mas não responde a input
- **Solução**: Reiniciar completamente o Claude Code

**Shift+Enter Não Funciona (Issue #1262)**
- **Problema**: No WSL/Windows 10, Shift+Enter submete input ao invés de nova linha
- **Workarounds**:
  - Usar `Tab+Enter` em VS Code terminal
  - Usar `\` seguido de Enter para continuar linha
  - Configurar `/terminal-setup` se disponível

#### Problemas de Performance WSL2

**Detecção de IDE Falha**
- **Causa**: Configuração de rede WSL2 (NAT) bloqueia conexões
- **Soluções**:
  - Configurar Windows Firewall para permitir tráfego WSL2
  - Usar modo mirrored networking
  - Verificar se npm/node apontam para versões Linux (não `/mnt/c/`)

**Performance Degradada**
- **Otimizações**:
  ```bash
  # ~/.wslconfig
  [wsl2]
  memory=8GB
  processors=4
  ```
  - Usar arquivos no filesystem Linux (`/home/`) não Windows (`/mnt/c/`)
  - Atualizar WSL2: `wsl --update`

### 2. Limitações Específicas com Vim/Aplicações Interativas

#### Vim Bindings Limitados

**Claude Code Vim Mode**
- ✅ **Suportado**: `h/j/k/l`, `w/e/b`, `0/$`, `x`, `dw/dd`, `i/a`
- ❌ **Não Suportado**: `f/F/t/T`, `ciw/yiw/diw`, comandos complexos
- **Issues Abertas**: #126, #1204, #4041

#### Problemas com Aplicações Interativas

**Terminal Corruption com Editores**
- **Problema**: Executar `vim`, `nano`, `less` pode corromper terminal
- **Causa**: Conflito entre controle de terminal do Claude Code e da aplicação
- **Recomendação**: **Evitar** executar editores interativos via Claude Code bash

**ESC Key Issues (JetBrains)**
- **Problema**: ESC não interrompe Claude Code em terminais JetBrains
- **Solução**:
  ```
  Settings → Tools → Terminal
  - Desmarcar "Move focus to the editor with Escape"  
  - Remover shortcut "Switch focus to Editor"
  ```

## ✅ Boas Práticas por Contexto

### 1. Terminal Comum (zsh/Windows Terminal)

#### Configuração Segura de Permissões

**Princípio: Apenas Read-Only Auto-Execute**
```bash
# ✅ Permitir auto-execute
git status
ls -la
cat arquivo.txt
grep "pattern" arquivo.txt

# ❌ NUNCA auto-execute  
git add .
rm arquivo.txt
git commit
npm install
```

**Configuração em ~/.claude.json**
```json
{
  "permissions": {
    "allow": [
      "Read(./src/**)",
      "Read(./docs/**)",
      "Bash(git status)",
      "Bash(ls *)"
    ],
    "deny": [
      "Read(./.env*)",
      "Read(./secrets/**)",
      "Read(./config/credentials.json)",
      "Bash(rm *)",
      "Bash(git add .)",
      "Bash(npm install)"
    ]
  }
}
```

#### Gerenciamento de Contexto

**Use `/clear` Frequentemente**
```bash
# Início de cada nova feature/problema
/clear

# Sempre que mudar de projeto
cd ~/outro-projeto
/clear
```

**Comandos de Limpeza**
- `/clear`: Limpa contexto completamente
- `/compact`: Resume conversa mantendo info importante
- `/cost`: Verifica uso de tokens

#### Comandos Seguros para Auto-Execute

```bash
# Informações do sistema
git status -sb
git log --oneline -10
ls -la
pwd
whoami
df -h

# Leitura de arquivos
cat arquivo.txt
head -20 arquivo.log
tail -f app.log | head -50  # Limitado para evitar flood
grep -n "error" *.log

# Status de processos
ps aux | grep processo
netstat -tulpn | grep :8080
```

### 2. Terminal Integrado do Vim (`:term`)

#### Configurações Recomendadas

**Mapeamentos para Vim Terminal**
```vim
" Adicionar ao vimrc
" Terminal mappings para Claude Code
nnoremap <leader>cc :term claude<CR>
nnoremap <leader>ch :term claude --headless -p "

" Sair do modo terminal facilmente  
tnoremap <Esc><Esc> <C-\><C-n>

" Navegação entre splits no modo terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
```

**Fluxo de Trabalho Recomendado**
1. **Edição Principal**: Use Vim para código
2. **Terminal Claude**: Use `:term claude` para assistência IA
3. **Alternação**: `Ctrl+w+h/j/k/l` entre editor e Claude
4. **Comandos Rápidos**: Use headless mode para tarefas específicas

#### Modo Headless para Automação

```bash
# No terminal integrado do vim
claude --headless -p "Revise este arquivo para bugs de segurança" arquivo.py
claude --headless -p "Explique esta função" --output-format stream-json
```

#### Evitar no Terminal Integrado

```bash
# ❌ NÃO FAÇA - Pode corromper terminal
claude # sem --headless
vim arquivo.txt  # via Claude Code bash
nano arquivo.txt # via Claude Code bash  
less arquivo.log # via Claude Code bash
```

### 3. Configurações Avançadas

#### Skip Permissions (Desenvolvimento Rápido)

```bash
# Para desenvolvimento rápido (USE COM CUIDADO)
claude --dangerously-skip-permissions

# Ou configure alias
echo 'alias cc="claude --dangerously-skip-permissions"' >> ~/.zshrc
```

**⚠️ ATENÇÃO**: Apenas use em projetos de teste/desenvolvimento

#### CLAUDE.md para Projetos

```markdown
# CLAUDE.md - Configurações do Projeto

## Comandos Seguros
- git status/log/diff: ✅ Auto-execute
- git add/commit/push: ❌ Perguntar sempre
- npm install: ❌ Perguntar sempre

## Arquivos Sensíveis  
- .env*: Nunca ler
- secrets/: Nunca acessar
- build/: Ignorar

## Padrões do Projeto
- Branch naming: feature/nome-da-feature
- Commit style: conventional commits
- Testing: npm test antes de commit

## Problemas Conhecidos
- Terminal corruption com aplicações interativas
- Usar headless mode para operações batch
```

## 🔧 Soluções da Comunidade

### 1. Plugins Neovim

#### claude-code.nvim (greggh/claude-code.nvim)

**Instalação**
```lua
-- lazy.nvim
{
  'greggh/claude-code.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('claude-code').setup({
      claude_executable = 'claude',
      toggle_key = '<leader>cc',
      auto_reload = true
    })
  end
}
```

**Recursos**
- Toggle Claude Code com uma tecla
- Auto-reload de arquivos modificados
- Suporte a argumentos de linha de comando
- Detecção automática de modificações

#### coder/claudecode.nvim (Implementação MCP)

**Instalação**
```lua
-- lazy.nvim  
{
  'coder/claudecode.nvim',
  config = function()
    require('claudecode').setup({
      port = 8080,
      auto_start = true
    })
  end
}
```

**Recursos**
- Protocolo WebSocket MCP completo
- Compatibilidade com extensão oficial VS Code
- Zero dependências externas
- Implementação 100% Lua

### 2. Plugin Vim Tradicional

#### pasky/claude.vim

```vim
" No vimrc
Plugin 'pasky/claude.vim'

" Configuração
let g:claude_api_key = $ANTHROPIC_API_KEY
let g:claude_model = 'claude-3-sonnet'

" Mapeamentos
nnoremap <leader>ai :ClaudeChat<CR>
vnoremap <leader>ai :ClaudeExplain<CR>
```

### 3. Configuração Terminal Multiplexer

#### Ghostty + Claude Code Setup

```bash
# Configuração Ghostty - 3 panes
# Pane 1: Neovim
# Pane 2: Claude Code  
# Pane 3: Terminal commands

# Navegação com Ctrl+vim keys
bind-key h select-pane -L
bind-key j select-pane -D  
bind-key k select-pane -U
bind-key l select-pane -R
```

## 🛠️ Troubleshooting

### Problemas Comuns e Soluções

#### 1. Claude Code Não Responde
```bash
# Verificar processo
ps aux | grep claude

# Matar processo travado
killall claude

# Limpar cache se necessário
rm -rf ~/.claude/cache/*

# Reiniciar
claude
```

#### 2. Terminal Corrompido
```bash
# Reset terminal
reset

# Ou força reset
tput reset

# Em casos extremos
kill -9 $$  # Mata shell atual
```

#### 3. Problemas de Permissão WSL2
```bash
# Verificar instalação Node/npm
which node  # Deve ser /usr/bin/node não /mnt/c/...  
which npm   # Deve ser /usr/bin/npm não /mnt/c/...

# Reinstalar Node via Linux se necessário
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Reinstalar Claude Code
npm uninstall -g @anthropic-ai/claude-code
npm install -g @anthropic-ai/claude-code
```

#### 4. Vim Bindings Não Funcionam
```bash
# Verificar/ativar vim mode
/vim

# Ou configurar permanentemente
/config
# Depois enable vim mode na interface
```

### Comandos de Diagnóstico

```bash
# Verificar status Claude Code
claude --version
claude --help

# Verificar configuração
cat ~/.claude/settings.json

# Verificar logs (se disponível)
tail -f ~/.claude/logs/claude.log

# Verificar contexto atual
# (no Claude Code)
/cost
/memory
```

### Comandos de Emergência

```bash
# Parar Claude Code imediatamente
Ctrl+C  # Cancela operação atual
Esc     # Para geração de resposta

# Sair completamente  
Ctrl+D  # EOF
/exit   # Comando de saída

# Reset completo de contexto
/clear

# Em terminal corrompido
reset && claude
```

## 📚 Configurações para Seu Ambiente

### Integração com Configuração Atual

**Adicionar ao ~/.zshrc**
```bash
# Claude Code aliases
alias cc='claude'
alias cch='claude --headless -p'
alias ccs='claude --dangerously-skip-permissions'  # Só para dev

# Função para Claude com contexto de projeto  
claude_project() {
    if [[ -f "CLAUDE.md" ]]; then
        echo "📋 CLAUDE.md encontrado, contexto do projeto carregado"
    fi
    claude "$@"
}
alias ccp='claude_project'

# Função para usar Claude no terminal vim de forma segura
claude_vim_safe() {
    echo "🔒 Modo seguro - headless apenas"
    claude --headless -p "$1"
}
alias ccv='claude_vim_safe'
```

**Configuração ~/.claude/settings.json Recomendada**
```json
{
  "model": "claude-3-sonnet-20241022",
  "permissions": {
    "allow": [
      "Read(./src/**)",
      "Read(./docs/**)", 
      "Read(./README.md)",
      "Read(./*.md)",
      "Bash(git status*)",
      "Bash(git log*)",
      "Bash(git diff*)",
      "Bash(ls*)",
      "Bash(grep*)",
      "Bash(find*)"
    ],
    "deny": [
      "Read(./.env*)",
      "Read(./secrets/**)",
      "Read(./config/database.yml)",
      "Read(./config/credentials*)",
      "Bash(rm*)",
      "Bash(git add*)", 
      "Bash(git commit*)",
      "Bash(npm install*)",
      "Bash(pip install*)",
      "Bash(sudo*)"
    ]
  },
  "terminal": {
    "vim_mode": true,
    "auto_clear_frequency": "per_project"
  }
}
```

**Adições ao vimrc:520**
```vim
" =============================================================================  
" CLAUDE CODE INTEGRATION
" =============================================================================

" Claude Code terminal integration
nnoremap <leader>cc :term claude<CR>
nnoremap <leader>ch :term claude --headless -p "

" Quick Claude commands 
nnoremap <leader>cai :term claude --headless -p "Explain this code"<CR>
nnoremap <leader>crv :term claude --headless -p "Review this file for bugs"<CR>
nnoremap <leader>crf :term claude --headless -p "Refactor this function"<CR>

" Visual mode - send selection to Claude
vnoremap <leader>ce y:term claude --headless -p "Explain: <C-r>""<CR>

" Terminal mode navigation (safer for Claude Code)
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-w>q <C-\><C-n>:q<CR>

" Function to safely use Claude in vim context
function! ClaudeSafe(prompt)
    " Save current buffer if modified
    if &modified
        write
    endif
    " Use headless mode to avoid terminal corruption
    execute 'term claude --headless -p "' . a:prompt . ' for file: ' . expand('%') . '"'
endfunction

command! -nargs=1 Claude call ClaudeSafe(<q-args>)
```

## 🎯 Workflow Recomendado Completo

### 1. Setup Inicial (Uma Vez)

```bash
# Instalar Claude Code
npm install -g @anthropic-ai/claude-code

# Configurar aliases
echo 'source ~/.claude_aliases' >> ~/.zshrc

# Criar arquivo de aliases
cat > ~/.claude_aliases << 'EOF'
alias cc='claude'
alias cch='claude --headless -p'
alias ccs='claude --dangerously-skip-permissions'
alias ccr='claude --restart'
EOF

# Configurar permissões padrão
mkdir -p ~/.claude
```

### 2. Workflow Diário

**No Terminal Principal (zsh)**
```bash
# Navegar para projeto
cd ~/projeto

# Inicializar contexto do projeto (se primeiro uso)
cc
/init  # Cria CLAUDE.md automaticamente
/clear

# Trabalho normal com Claude
cc
"Analise este projeto e sugira melhorias na arquitetura"
/clear quando terminar
```

**No Vim Terminal Integrado**
```bash
# Abrir Vim normalmente
vim

# Para consultas rápidas no vim
:term claude --headless -p "Explique esta função"

# Para revisões de arquivo
:term claude --headless -p "Revise este arquivo"

# Voltar ao código
Ctrl+w+h  # ou outro split
```

### 3. Padrões de Segurança

**Sempre Seguir**
- ✅ Use `/clear` entre diferentes tarefas/projetos
- ✅ Revise comandos destrutivos antes de confirmar
- ✅ Use headless mode em scripts/automação
- ✅ Mantenha `.env` e secrets em deny list
- ❌ Nunca auto-execute comandos git add/commit
- ❌ Nunca execute editores interativos via Claude bash
- ❌ Nunca use skip-permissions em produção

## 📖 Referências e Links Úteis

### Documentação Oficial
- [Claude Code Overview](https://docs.anthropic.com/en/docs/claude-code/overview)
- [Terminal Configuration](https://docs.anthropic.com/en/docs/claude-code/terminal-config)  
- [Troubleshooting](https://docs.anthropic.com/en/docs/claude-code/troubleshooting)
- [Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Issues Relevantes GitHub
- [Vim Bindings Enhancement #126](https://github.com/anthropics/claude-code/issues/126)
- [Terminal Corruption #5671](https://github.com/anthropics/claude-code/issues/5671)  
- [WSL CLI Hang #619](https://github.com/anthropics/claude-code/issues/619)
- [Shift+Enter WSL #1262](https://github.com/anthropics/claude-code/issues/1262)

### Plugins da Comunidade
- [claude-code.nvim](https://github.com/greggh/claude-code.nvim)
- [claude.vim](https://github.com/pasky/claude.vim)
- [claudecode.nvim](https://github.com/coder/claudecode.nvim)

### Recursos Adicionais
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code)
- [Builder.io Guide](https://www.builder.io/blog/claude-code)

## 🚧 Otimizações Realizadas

### Implementações Testadas e Revertidas

**Data**: 2025-09-09

#### ❌ Aliases Claude Code (Revertido)
- **Arquivo**: `~/.claude_aliases` 
- **Status**: Removido
- **Motivo**: Implementação revertida a pedido do usuário
- **Configurações que foram testadas**:
  - `cc='claude'` - Alias básico
  - `cch='claude --headless -p'` - Headless mode
  - `ccs='claude --dangerously-skip-permissions'` - Skip permissions  
  - `ccp='claude_project'` - Função com contexto CLAUDE.md
  - `ccv='claude_vim_safe'` - Modo seguro para vim

#### ❌ Integração zshrc (Revertida)
- **Arquivo**: `/home/notebook/config/zshrc`
- **Status**: Source removido
- **Alteração**: Remoção da linha `source ~/.claude_aliases`

#### ⏸️ Mapeamentos Vim (Não Implementado)
- **Arquivo**: `/home/notebook/config/vimrc`
- **Status**: Não adicionado
- **Mapeamentos planejados**: `<leader>cc`, `<leader>ch`, `<leader>cai`, etc.
- **Função**: `ClaudeSafe()` para uso seguro no vim

### Estado Atual do Ambiente

O ambiente permanece no estado original, sem modificações nas configurações de aliases ou mapeamentos Claude Code. As implementações sugeridas no guia permanecem como **recomendações opcionais** para implementação futura conforme necessidade do usuário.

### Próximos Passos Sugeridos

1. **Avaliação**: Determinar se alguma configuração específica é necessária
2. **Implementação Seletiva**: Escolher apenas aliases/mapeamentos úteis
3. **Teste Gradual**: Implementar e testar uma configuração por vez

---

**Última atualização**: 2025-09-09  
**Ambiente testado**: WSL2 Ubuntu 24.04 + Vim 9.1 + Windows Terminal  
**Claude Code Version**: Latest stable