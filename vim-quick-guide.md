# 🚀 Guia Rápido: Vim Otimizado - Recursos Ativos

## ⚡ **Atalhos Principais**

### **🔍 Navegação e Busca (FZF)**
```vim
Ctrl+P          " Buscar arquivos no projeto
Ctrl+B          " Lista de buffers abertos
Ctrl+F          " Busca texto com ripgrep
,h              " Histórico de arquivos
,:              " Histórico de comandos
,/              " Histórico de buscas
```

### **💾 Comandos Rápidos (Leader = ,)**
```vim
,w              " Salvar arquivo
,q              " Sair
,x              " Salvar e sair
,<space>        " Limpar highlight de busca
,s              " Toggle spell check
,n              " Toggle números de linha
,rn             " Toggle números relativos
,l              " Toggle caracteres ocultos
,wr             " Toggle quebra de linha
```

### **🔄 Git Integration (Fugitive)**
```vim
,gs             " Git status
,ga             " Git add .
,gc             " Git commit
,gp             " Git push
,gl             " Git log --oneline
,gd             " Git diff split
```

### **🪟 Navegação entre Splits**
```vim
Ctrl+H          " Split esquerda
Ctrl+J          " Split abaixo
Ctrl+K          " Split acima
Ctrl+L          " Split direita
```

### **📑 Gerenciamento de Tabs**
```vim
,tn             " Nova tab
,tc             " Fechar tab
,tm             " Mover tab
,t,             " Próxima tab
```

### **📋 Gerenciamento de Buffers**
```vim
,bp             " Buffer anterior
,bn             " Próximo buffer
,bd             " Fechar buffer
```

## 🛠️ **Recursos de Desenvolvimento**

### **🧠 LSP (Language Server Protocol)**
*Funciona automaticamente para C, Python, TypeScript*
```vim
gd              " Ir para definição
gr              " Listar referências
gi              " Ir para implementação
gt              " Ir para tipo
K               " Mostrar documentação
,rn             " Renomear símbolo
[g              " Erro anterior
]g              " Próximo erro
```

### **💬 Comentários (NERDCommenter)**
```vim
<leader>cc      " Comentar linha/seleção
<leader>cu      " Descomentar
<leader>c<space> " Toggle comentário
```

### **🎨 HTML/CSS (Emmet)**
*Ativo em arquivos HTML, CSS, JS*
```vim
Ctrl+E,         " Expandir abreviação Emmet
" Exemplo: div.container>ul>li*3 + Ctrl+E,
```

### **✂️ Snippets (Vsnip)**
```vim
Tab             " Próximo placeholder
Shift+Tab       " Placeholder anterior
```

### **🔄 Surround (Manipular delimitadores)**
```vim
cs"'            " Mudar "texto" para 'texto'
cs'<p>          " Mudar 'texto' para <p>texto</p>
ds"             " Remover aspas
ysiw]           " Adicionar [] ao redor da palavra
```

## 📁 **Configurações por Tipo de Arquivo**

### **C/C++**
- Indentação: 4 espaços
- Comentários: `//`
- Fold: Syntax
- LSP: clangd

### **Python**  
- Indentação: 4 espaços
- Linha em 80 caracteres
- Fold: Indent
- LSP: pylsp

### **Web (HTML/CSS/JS)**
- Indentação: 2 espaços  
- Emmet ativo
- Fold: Syntax/Indent
- LSP: typescript-language-server

### **Markdown**
- Wrap ativo
- Spell check ativo
- Concealment level 2

### **YAML/JSON**
- Indentação: 2 espaços
- Fold: Syntax

## 🎯 **Recursos Avançados**

### **🔍 Busca Inteligente**
- Case-insensitive por padrão
- Smart case (maiúscula = case-sensitive)
- Highlight automático
- Incremental search

### **📝 Autocompletion**
- Setas: navegação
- Enter/→: aceitar
- ←: cancelar
- `Ctrl+X H`: hashbangs

### **🔄 Undo Avançado**
- Persistente entre sessões
- `:earlier 1h` - voltar 1 hora
- `:later 30m` - avançar 30 minutos

### **🎨 Visual**
- True color support
- Tema: habamax transparente
- Statusline com modo dinâmico
- Números relativos + absolutos

## 🚫 **Soluções de Problemas**

### **Plugin não funciona**
```vim
:PlugStatus     " Verificar status
:PlugUpdate     " Atualizar plugins
:PlugInstall    " Reinstalar se necessário
```

### **LSP não funciona**
```vim
:LspStatus      " Verificar language server
:LspInstallServer " Instalar servidor manualmente
```

### **FZF não encontra arquivos**
- Verifique se está no diretório do projeto
- `ripgrep` deve estar instalado para `:Rg`

## 📊 **Estatísticas**

**Configuração atual:**
- ✅ **520 linhas** de configuração (+208% melhorias)
- ✅ **17 plugins** ativos e configurados (era 0 antes!)  
- ✅ **Plugin manager** vim-plug funcionando perfeitamente
- ✅ **LSP** configurado para C, Python, TypeScript
- ✅ **Performance** otimizada com startup rápido
- ✅ **FZF** busca fuzzy profissional
- ✅ **Git workflow** integrado
- ✅ **Airline** statusline moderna

## 🎆 **ATUALIZAÇÃO: TODAS AS MELHORIAS IMPLEMENTADAS!**

### ✅ **Novidades Ativadas (06/08/2025)**

#### **🔥 Recursos que NÃO existiam antes:**
- **FZF Fuzzy Search**: `Ctrl+P` para buscar arquivos instantaneamente
- **LSP IntelliSense**: `gd` para go-to-definition, `K` para documentação
- **Git Integration**: `,gs` status, `,ga` add all, `,gc` commit, `,gp` push
- **Snippets Automáticos**: Templates com `Tab` para navegar
- **Emmet HTML**: `div.container>ul>li*3` + `Ctrl+E,` = mágica!
- **Comments**: `<leader>cc` comenta qualquer código inteligentemente
- **Surround**: `cs"'` muda "texto" para 'texto' instantaneamente

#### **🎆 O que mudou dramaticamente:**
```bash
# ANTES: Apenas vim básico
vim arquivo.c  # Só editing básico

# AGORA: IDE completo
vim arquivo.c  # LSP + autocomplete + git + snippets + tudo!
```

#### **🔥 Performance Boost:**
- **Startup**: Otimizado, carrega rápido mesmo com 17 plugins
- **Busca**: FZF é MUITO mais rápido que busca nativa
- **Development**: LSP dá feedback em tempo real

## 📦 **Arquivos de Suporte Criados**

```bash
/home/joao/config/
├── vimrc                 # 🔄 EXPANDIDO: 168→520 linhas
├── vimrc.backup          # 🔒 Backup da versão anterior
├── vim-README.md         # 📚 Documentação completa
├── vim-quick-guide.md    # 🚀 Este guia rápido
└── vim-diagnostic.sh     # 🔍 Script de diagnóstico
```

---

## 📞 **Comandos de Diagnóstico**

```bash
# Diagnóstico completo colorido
vim-diag

# Verificar plugins ativos
vim -c 'PlugStatus'

# Testar FZF
vim -c 'Files'

# Status LSP
vim -c 'LspStatus'
```

**💡 Dica:** Execute `vim-diag` no terminal para diagnóstico completo!
**📚 Documentação completa:** `/home/joao/config/vim-README.md`
**⚡ Status:** OTIMIZAÇÃO COMPLETA - PRONTO PARA USO PROFISSIONAL!
