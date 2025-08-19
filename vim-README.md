# 📝 Configuração Vim - Diagnóstico e Diretrizes

## 📊 **Status Atual da Configuração (ATUALIZADO - 06/08/2025)**

### ✅ **CONFIGURAÇÃO OTIMIZADA - TODAS AS MELHORIAS IMPLEMENTADAS**

#### **1. Plugin System - ATIVO ✅**
- ✅ **vim-plug**: Configurado e funcionando perfeitamente
- ✅ **17 Plugins**: Todos ativos e configurados (era 0 plugins antes)
- ✅ **Autoinstalação**: `PlugInstall` e `PlugUpdate` funcionais
- ✅ **Gerenciamento**: Sistema de plugins totalmente operacional

#### **2. Navegação e Busca Profissional - ATIVO ✅**
- ✅ **FZF**: Busca fuzzy ultrarrápida (`Ctrl+P` arquivos, `Ctrl+F` conteúdo)
- ✅ **Buffers**: Gerenciamento avançado com `Ctrl+B`
- ✅ **Histórico**: Acesso a histórico de arquivos, comandos e buscas
- ✅ **Performance**: Wildignore otimizado para projetos grandes

#### **3. Development Tools - NÍVEL IDE ✅**
- ✅ **LSP**: Language Server Protocol para C, Python, TypeScript
- ✅ **Autocompleção**: Context-aware com `gd` (go-to-definition), `gr` (references)
- ✅ **Git Integration**: vim-fugitive com shortcuts `,gs`, `,ga`, `,gc`, `,gp`
- ✅ **Snippets**: vim-vsnip com templates automáticos
- ✅ **Emmet**: Expansão HTML/CSS com `Ctrl+E,`

#### **4. Interface Moderna - AIRLINE ATIVO ✅**
- ✅ **Statusline**: vim-airline substituindo configuração manual
- ✅ **DevIcons**: Ícones para tipos de arquivo
- ✅ **Temas**: Base16 + transparência otimizada
- ✅ **Tabline**: Abas com informações de git e encoding

#### **5. Produtividade Máxima - LEADER KEY ✅**
- ✅ **Leader Key**: `,` configurada para workflows rápidos
- ✅ **Comandos rápidos**: `,w` (save), `,x` (save+quit), `,s` (spell)
- ✅ **Navegação**: `Ctrl+H/J/K/L` para splits, `,bp/bn` para buffers
- ✅ **Toggles**: `,n` (numbers), `,l` (list chars), `,wr` (wrap)

### 🎯 **PROBLEMAS CRÍTICOS - TODOS RESOLVIDOS ✅**

#### **✅ RESOLVIDO: Plugin Manager** ```bash
STATUS ANTERIOR: vim-plug instalado mas não referenciado
STATUS ATUAL: ✅ ATIVO - 17 plugins carregados e funcionando
IMPACTO: Funcionalidades IDE completas disponíveis
```

#### **✅ RESOLVIDO: Configurações por Linguagem**
- **C/C++**: Indentação 4 espaços, cindent, LSP clangd
- **Python**: PEP8 compliance, line at 80, LSP pylsp
- **Web Dev**: 2 espaços, Emmet ativo, TypeScript LSP
- **Markdown**: Wrap + spell check automático
- **YAML/JSON**: 2 espaços, syntax folding

#### **✅ RESOLVIDO: Performance**
- **Startup**: Plugins desnecessários desabilitados
- **Redraw**: `ttyfast` + `lazyredraw` otimizado
- **Timeouts**: 500ms para comandos, 10ms para keys
- **Memory**: Histórico limitado, cache otimizado

## 📋 **Diretrizes de Uso da Configuração Atual**

### 🚀 **Comandos Funcionais (Sem Plugins)**

#### **Edição Básica**
```vim
" Navegação
h, j, k, l          " Movimento básico
Ctrl+u, Ctrl+d      " Page up/down
gg, G              " Início/fim do arquivo

" Busca
/termo             " Buscar para frente
?termo             " Buscar para trás
n, N               " Próxima/anterior ocorrência
:noh               " Limpar highlight de busca

" Edição
i, a               " Insert mode antes/depois do cursor
o, O               " Nova linha abaixo/acima
u                  " Undo
Ctrl+r             " Redo
```

#### **Autocompletion Personalizada**
```vim
" No modo insert:
Ctrl+n             " Next completion
Ctrl+p             " Previous completion
↑/↓                " Navegar completions (personalizado)
→/Enter            " Aceitar completion (personalizado)
←                  " Cancelar completion (personalizado)

" Hashbangs especiais:
Ctrl+x h           " Inserir hashbang comum
```

#### **Recursos Avançados Ativos**
```vim
:set spell         " Ativar correção PT-BR/EN
:set list          " Mostrar caracteres ocultos
:set wrap          " Ativar quebra de linha
:earlier 1h        " Voltar ao estado de 1 hora atrás
:later 30m         " Avançar 30 minutos no histórico
```

### 📁 **Estrutura de Arquivos ATUAL**
```bash
~/.vim/
├── autoload/
│   └── plug.vim           # ✅ Plugin manager ATIVO
├── plugged/              # ✅ 17 plugins CARREGADOS
│   ├── fzf/              # ✅ Fuzzy finder ativo
│   ├── vim-airline/      # ✅ Statusline avançada ativa
│   ├── emmet-vim/        # ✅ HTML expansion ativo
│   ├── vim-lsp/          # ✅ LSP ativo (C, Python, TS)
│   ├── vim-fugitive/     # ✅ Git integration ativa
│   ├── nerdcommenter/    # ✅ Comentários inteligentes
│   ├── vim-surround/     # ✅ Manipulação de delimitadores
│   ├── vim-vsnip/        # ✅ Snippets ativos
│   └── ...               # + 9 plugins adicionais
├── undodir/              # ✅ Histórico de undo persistente
├── spell/                # ✅ Dicionários spell check
└── vsnip/                # ✅ Diretório de snippets customizados

/home/joao/config/
├── vimrc                 # ✅ Configuração principal (520 linhas)
├── vimrc.backup          # ✅ Backup seguro da versão anterior
├── vim-README.md         # ✅ Este documento
├── vim-quick-guide.md    # ✅ Guia rápido de uso
└── vim-diagnostic.sh     # ✅ Script de diagnóstico automático
```

## 🎉 **CONFIGURAÇÃO COMPLETA - MELHORIAS IMPLEMENTADAS**

### ✅ **TODAS AS FUNCIONALIDADES ATIVAS**

#### **🔍 FZF - Busca Fuzzy Profissional**
```vim
Ctrl+P              # Buscar arquivos no projeto
Ctrl+B              # Lista de buffers abertos
Ctrl+F              # Busca texto com ripgrep
,h                  # Histórico de arquivos
,:                  # Histórico de comandos
,/                  # Histórico de buscas
```
#### **🧠 LSP - IntelliSense Completo**
```vim
gd                  # Go-to-definition
gr                  # Listar referências  
gi                  # Go-to-implementation
gt                  # Go-to-type-definition
K                   # Mostrar documentação
,rn                 # Renomear símbolo
[g / ]g             # Navegar entre erros
```

**🔍 EXEMPLOS PRÁTICOS DE USO LSP:**

**Cenário 1: Desenvolvimento em C**
```c
// arquivo: main.c
#include <stdio.h>

void process_data(int *data, size_t len) {
    // Cursor em 'process_data' -> pressione 'gd'
    // RESULTADO: LSP mostra definição da função
}

int main() {
    int numbers[] = {1, 2, 3};
    process_data(numbers, 3);  // Cursor aqui -> 'gr' mostra todas as chamadas
    return 0;
}
```

**Como usar:**
1. **`gd` (Go-to-Definition)**: Coloque cursor em `process_data()` na linha 9 e pressione `gd`
   - **Resultado**: Vim pula automaticamente para linha 3 onde a função é definida
   - **Útil para**: Navegar rapidamente entre chamadas e definições

2. **`gr` (Go-to-References)**: Cursor em `process_data` (linha 3) + `gr`
   - **Resultado**: Lista todas as ocorrências da função no projeto
   - **Interface**: Janela QuickFix com lista navegável

**Cenário 2: Desenvolvimento Python**
```python
# arquivo: calculator.py
class Calculator:
    def add(self, a, b):        # Cursor aqui + 'gr' -> mostra todas as chamadas
        return a + b
    
    def multiply(self, a, b):
        return self.add(a, 0) + (a * (b-1))  # Cursor em 'add' + 'gd'

# arquivo: main.py
from calculator import Calculator
calc = Calculator()
result = calc.add(5, 3)  # Cursor em 'add' + K -> mostra docstring
```

**Como usar:**
3. **`K` (Hover Documentation)**: Cursor em método/função + `K`
   - **Python**: Mostra docstring, tipo de retorno, parâmetros
   - **C**: Mostra signature da função, comentários de header
   - **TypeScript**: Mostra tipos, JSDoc, exemplos

4. **`,rn` (Rename Symbol)**: Cursor em variável/função + `,rn`
   - **Prompt**: Digite novo nome
   - **Resultado**: Renomeia em TODAS as ocorrências do projeto
   - **Seguro**: LSP garante que só renomeia o símbolo correto

**Cenário 3: Detecção de Erros em Tempo Real**
```c
// Erro intencional:
int main() {
    char *ptr = malloc(100);  // ❌ Erro: malloc não declarado
    printf("%s", ptr);       // ⚠️  Warning: printf não seguro
    return 0;                 // ❌ Memory leak: free() não chamado
}
```

**Como usar:**
5. **`]g` / `[g` (Navigate Diagnostics)**: Pular entre erros
   - **Visual**: Linha sublinhada em vermelho/amarelo
   - **Cursor em erro + K**: Mostra descrição detalhada
   - **Fix sugerido**: LSP pode sugerir `#include <stdlib.h>`
#### **🔄 Git Integration Completa**
```vim
,gs                 # Git status
,ga                 # Git add .
,gc                 # Git commit
,gp                 # Git push
,gl                 # Git log --oneline
,gd                 # Git diff visual split
```

**📖 GUIA COMPLETO VIM-FUGITIVE:**

**Workflow Básico Git no Vim:**
```bash
# Cenário: Você está editando um projeto e quer fazer commit
# Arquivo: projeto.c (modificado)
```

**1. Verificar Status do Repositório**
```vim
,gs                 # Abre janela de status git
```
**Resultado:**
```
# On branch main
# Changes not staged for commit:
#   modified:   src/projeto.c
#   modified:   README.md
# Untracked files:
#   config/new_file.txt
```

**Interface vim-fugitive:**
- **Navegação**: `j/k` para mover entre arquivos
- **Stage arquivo**: Cursor no arquivo + `s` (staging)
- **Unstage arquivo**: Cursor no arquivo staged + `u`
- **Ver diff**: Cursor no arquivo + `=` (mostra diferenças)
- **Abrir arquivo**: `Enter` ou `o`

**2. Staging Interativo**
```vim
# Na janela de status:
# Cursor em 'src/projeto.c' -> pressione 's'
# RESULTADO: Arquivo vai para "Changes to be committed"
```

**3. Commit Visual**
```vim
,gc                 # Abre editor de commit
```
**Interface de Commit:**
```
# Please enter the commit message for your changes.
# Lines starting with '#' will be ignored.
#
# On branch main
# Changes to be committed:
#       modified:   src/projeto.c
```
**Como usar:**
- Digite mensagem de commit na primeira linha
- `:wq` para salvar e fazer commit
- `:q!` para cancelar

**4. Visualização de Diferenças**
```vim
,gd                 # Git diff em split visual
```
**Resultado: Split de 3 paineis**
```
┌────────────────┐┌────────────────┐
│   ORIGINAL      ││    MODIFIED     │
│ (como estava)  ││ (como está)    │
│                ││                │
│ - linha antiga ││ + linha nova   │
│                ││                │
└────────────────┘└────────────────┘
```

**Navegação no Diff:**
- **`]c` / `[c`**: Próximo/anterior chunk de diferenças
- **`dp`**: Put (aplicar mudança do painel esquerdo para direito)
- **`do`**: Obtain (obter mudança do painel direito para esquerdo)
- **`:diffupdate`**: Atualizar highlights do diff

**5. Log Visual Interativo**
```vim
,gl                 # Git log visual
```
**Interface:**
```
* abc1234 (HEAD -> main) Fix bug in parser
* def5678 Add new feature
* ghi9012 Initial commit
```

**Ações no Log:**
- **`Enter`**: Ver details do commit
- **`o`**: Abrir commit em nova janela
- **`O`**: Abrir commit em nova aba
- **`q`**: Fechar janela de log

**🚀 WORKFLOWS AVANÇADOS:**

**Workflow 1: Resolução de Conflitos**
```vim
# Situação: Merge conflict
:Git merge feature-branch
# RESULTADO: Conflict detected

,gd                 # Abrir diff de 3 vias
```
**Interface de Merge:**
```
┌── TARGET ──┐┌── WORKING ──┐┌── MERGE ───┐
│            ││             ││            │
│ branch A   ││   RESULT    ││ branch B   │
│            ││             ││            │
└────────────┘└─────────────┘└────────────┘
```

**Comandos de Resolução:**
- **`]c`**: Próximo conflito
- **`[c`**: Conflito anterior
- **`dp`**: Usar versão da esquerda
- **`do`**: Usar versão da direita
- **`:wqa`**: Salvar solução de todos os arquivos

**Workflow 2: Blame/Anotações de Código**
```vim
:Git blame          # ou :Gblame
```
**Interface:**
```
abc1234 (João   2025-08-06 12:30:45 -0300  1) #include <stdio.h>
def5678 (Maria  2025-08-05 14:15:20 -0300  2) 
ghi9012 (Pedro  2025-08-04 09:45:10 -0300  3) int main() {
jkl3456 (João   2025-08-06 16:20:30 -0300  4)     printf("Hello");
```

**Navegação no Blame:**
- **`Enter`**: Ver commit completo
- **`o`**: Abrir commit em split
- **`q`**: Fechar blame
- **`A`**: Resize author column

**Workflow 3: Branch Management**
```vim
:Git branch         # Listar branches
:Git checkout -b feature/nova    # Criar nova branch
:Git checkout main               # Trocar para main
:Git merge feature/nova          # Merge branch
```

#### **✂️ Snippets (vim-vsnip) - Templates de Código**

```vim
Tab                 # Próximo placeholder do snippet
Shift+Tab           # Placeholder anterior
```

**📖 GUIA RÁPIDO DE SNIPPETS:**

**Cenário 1: Desenvolvimento HTML**
```html
<!-- Digite 'html5' e pressione Tab -->
<!-- RESULTADO: Template HTML5 completo com placeholders -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$1</title>
</head>
<body>
    $0
</body>
</html>
```

**Como usar snippets:**
1. **Digitar abreviatura** + `Tab` para expandir
2. `Tab` para navegar entre placeholders (`$1`, `$2`, etc.)
3. Editar cada placeholder conforme necessário
4. `$0` marca a posição final após preencher o snippet

**Snippets populares por linguagem:**

**C/C++**
- `main` → Estrutura principal com int main()
- `for` → Loop for completo com i, n
- `if` → Estrutura if-else
- `func` → Declaração de função

**Python**
- `def` → Função completa com docstring
- `class` → Classe com método __init__
- `if` → Estrutura if-elif-else
- `for` → Loop for com range

**JavaScript**
- `fn` → Arrow function
- `clog` → console.log()
- `forin` → Loop for...in
- `then` → Promise.then()

**HTML/CSS**
- `link` → Link stylesheet
- `img` → Imagem com alt
- `ul` → Lista não ordenada
- `flexbox` → CSS flexbox container

**Criando snippets personalizados:**
```bash
# Diretório de snippets customizados
mkdir -p ~/.vim/vsnip

# Criar snippet para linguagem específica
vim ~/.vim/vsnip/c.json
```

**Formato de snippet (exemplo JSON):**
```json
{
  "Function Template": {
    "prefix": ["fn"],
    "body": [
      "/**",
      " * ${1:description}",
      " * @param ${2:param} ${3:description}",
      " * @return ${4:description}",
      " */",
      "${5:return_type} ${6:function_name}(${7:parameters}) {\n\t$0\n}"
    ],
    "description": "Function template with documentation"
  }
}
```

#### **📁 Yazi File Manager - Gerenciador de Arquivos Moderno**

```bash
y                   # Abrir yazi (alias)
yy                  # Yazi com integração cd
fm                  # File manager (alias)
yc                  # Yazi config directory
yw                  # Yazi workspace directory
yh                  # Yazi home directory
```

**📖 GUIA COMPLETO YAZI INTEGRATION:**

O **Yazi** é um gerenciador de arquivos moderno em Rust, totalmente integrado ao seu ambiente de desenvolvimento:

**🚀 COMANDOS ESSENCIAIS DO YAZI:**

**Navegação Básica:**
```vim
j/k                 # Navegar para baixo/cima
h/l                 # Voltar/entrar em diretório  
gg/G                # Início/fim da lista
Space               # Selecionar arquivo
Enter               # Abrir arquivo/pasta
q                   # Sair do yazi
```

**Integração com Editores:**
```vim
,v                  # Abrir com Vim
,c                  # Abrir com VS Code
o                   # Abrir com aplicação padrão
O                   # Menu interativo de abertura
```

**Operações de Arquivo:**
```vim
y                   # Copiar (yank) arquivos
x                   # Recortar arquivos
p                   # Colar arquivos
d                   # Deletar para lixo
D                   # Deletar permanentemente
a                   # Criar arquivo
A                   # Criar diretório
r                   # Renomear arquivo
```

**Busca e Filtragem:**
```vim
s                   # Buscar por nome (fd)
S                   # Buscar conteúdo (ripgrep)
/                   # Filtrar arquivos
n/N                 # Próximo/anterior resultado
Ctrl+s              # Cancelar busca
```

**Git Integration:**
```vim
,gs                 # Git status
,gl                 # Git log
,gd                 # Git diff
,ga                 # Git add all
```

**Organização e Visualização:**
```vim
,a                  # Ordenar alfabeticamente
,m                  # Ordenar por modificação
,s                  # Ordenar por tamanho
,e                  # Ordenar por extensão
,.                  # Toggle arquivos ocultos
,r                  # Refresh diretório
```

**🎯 WORKFLOWS PRÁTICOS COM YAZI:**

**Workflow 1: Desenvolvimento de Projeto**
```bash
# 1. Navegar para workspace
yw                  # Abre yazi no workspace

# 2. Encontrar arquivo específico
s                   # Digite nome do arquivo
# Resultado: Lista filtrada

# 3. Abrir no editor preferido
,v                  # Vim para edição rápida
,c                  # VS Code para desenvolvimento
```

**Workflow 2: Gestão de Arquivos de Config**
```bash
# 1. Ir para configurações
yc                  # Diretório de config

# 2. Ver status git das configs
,gs                 # Mostra arquivos modificados

# 3. Editar configuração específica
vimrc               # Digite parte do nome
,v                  # Abrir com Vim
```

**Workflow 3: Operações em Lote**
```bash
# 1. Selecionar múltiplos arquivos
Space               # Em cada arquivo
# ou
v                   # Modo visual para seleção em range

# 2. Operação em lote
y                   # Copiar todos selecionados
# Navegar para destino
p                   # Colar todos
```

**Workflow 4: Busca Avançada de Conteúdo**
```bash
# 1. Busca em conteúdo de arquivos
S                   # Ripgrep search
"function main"     # Buscar por função

# 2. Navegar nos resultados
n/N                 # Próximo/anterior
,v                  # Abrir arquivo encontrado
```

**🔧 CONFIGURAÇÕES PERSONALIZADAS:**

**Atalhos de Diretórios Rápidos:**
```bash
gw                  # Ir para workspace
gv                  # Ir para config
gh                  # Ir para home
gc                  # Ir para ~/.config
gd                  # Ir para Downloads
```

**Manipulação de Arquivos:**
```bash
,z                  # Extrair ZIP
,t                  # Listar conteúdo TAR
,x                  # Tornar executável
cc                  # Copiar caminho completo
cf                  # Copiar nome do arquivo
```

**Integração Shell (yy command):**
```bash
# O comando 'yy' é especial - altera o diretório do terminal após sair:
yy /path/to/project # Navega E muda pwd do terminal
# Útil para: navegar com yazi e continuar trabalhando no terminal
```

**🎨 INTERFACE E TEMAS:**

- **Layout**: 1:4:3 (sidebar:main:preview)
- **Tema**: Gruvbox-inspired com cores para linguagens
- **Icons**: Nerd Fonts para tipos de arquivo
- **Preview**: Syntax highlighting para código
- **Git status**: Indicadores visuais de modificações

**⚙️ ARQUIVOS DE CONFIGURAÇÃO:**
```bash
~/.config/yazi/
├── yazi.toml       # Configuração principal
├── keymap.toml     # Mapeamento de teclas customizado
└── theme.toml      # Tema visual personalizado
```

**🚨 TROUBLESHOOTING:**

**Problema 1: Aliases não funcionam**
```bash
# Solução: Recarregar zshrc
source ~/.zshrc
# ou
exec zsh
```

**Problema 2: yy() não muda diretório**
```bash
# Verificar se função está carregada:
declare -f yy
# Se não: reiniciar terminal
```

**Problema 3: Completions não aparecem**
```bash
# Verificar completions:
ls /usr/share/zsh/site-functions/_yazi
# Se não existe: reinstalar completions
```

**💡 DICAS DE PRODUTIVIDADE:**

1. **Use `yy` em vez de `y`** para navegação com cd integrado
2. **Configure bookmarks** com `g + tecla` para diretórios frequentes  
3. **Use busca por conteúdo (S)** para encontrar código rapidamente
4. **Combine com FZF** - Yazi para navegar, FZF no Vim para buscar
5. **Git workflow**: `yc` → `,gs` → editar → `,ga` → `,gc`

#### **⚡ Produtividade com Leader Key (,)**

```vim
,w                  # Salvar arquivo rápido
,x                  # Salvar e sair
,<space>            # Limpar highlight de busca
,s                  # Toggle spell check
,n                  # Toggle números
,l                  # Toggle caracteres ocultos
,wr                 # Toggle wrap
```

**⚠️ IMPORTANTE: MODO NORMAL OBRIGATÓRIO**

Todos os comandos com `,` (vírgula) **DEVEM** ser executados no **modo NORMAL** do Vim:

1. **Pressione `Esc`** para garantir que está em modo NORMAL
2. **Digite a sequência completa**: `,w` (sem espaço entre , e w)
3. **Aguarde 500ms** para o comando executar

**Teste rápido:**
```bash
# Execute o script de teste:
/home/joao/config/test-leader.sh
vim /tmp/vim_leader_test.txt

# Dentro do Vim:
# 1. ESC (modo normal)
# 2. ,w (salvar)
# 3. ,s (toggle spell) 
# 4. ,q (sair)
```

**💡 WORKFLOWS DE PRODUTIVIDADE MAXIMA:**

**1. Otimização de Navegação entre Splits**
```vim
Ctrl+H              # Split esquerda (em vez de Ctrl+W, h)
Ctrl+J              # Split abaixo
Ctrl+K              # Split acima
Ctrl+L              # Split direita
```

**2. Gerenciamento de Buffers Eficiente**
```vim
,bp                 # Buffer anterior
,bn                 # Buffer seguinte
,bd                 # Fechar buffer atual
Ctrl+B              # Lista de buffers (via FZF)
```

**3. Navegação rápida entre Tabs**
```vim
,tn                 # Nova tab
,tc                 # Fechar tab
,tm                 # Mover tab
,t,                 # Próxima tab
```

**4. Toggles Instantâneos de Configurações**
```vim
,s                  # Toggle spell check
,n                  # Toggle line numbers
,rn                 # Toggle relative numbers
,l                  # Toggle listchars
,wr                 # Toggle line wrap
```

**5. Workflows Avançados por Linguagem**

**Python:**
- `,<space>` depois `K` em função para documentação
- `gd` para pular para definição
- `,rn` para renomear variáveis com segurança

**Web Development:**
- `Ctrl+E,` para expandir Emmet abreviations
- `<div.container>` + `Ctrl+E,` = `<div class="container"></div>`
- `,s` para spellcheck em comentários

**Git Workflow Completo:**
```
1. Editar arquivos
2. ,gs (ver status)
3. Stage arquivos (cursor no arquivo + s)
4. ,gc (commit)
5. Escrever mensagem + :wq
6. ,gp (push)
```

## 📊 **ESTATÍSTICAS DE MELHORIA**

### **ANTES vs DEPOIS**

| Aspecto | ANTES | DEPOIS | Melhoria |
|---------|-------|---------|----------|
| **Linhas de config** | 168 | 520 | +208% |
| **Plugins ativos** | 0 | 17 | +∞% |
| **Funcionalidades** | Básicas | IDE-level | Profissional |
| **LSP Support** | ❌ | ✅ C, Python, TS | Completo |
| **Git Integration** | ❌ | ✅ vim-fugitive | Workflow |
| **Fuzzy Search** | ❌ | ✅ FZF | Ultrarrápido |
| **File Manager** | ❌ | ✅ Yazi | Moderno |
| **Autocompletion** | Básica | ✅ Context-aware | Inteligente |
| **Snippets** | ❌ | ✅ Templates | Automático |

## 🚀 **ROTEIRO COMPLETO - IMPLEMENTADO**

### ✅ **Fase 1: Plugin System - CONCLUÍDA**
- ✅ vim-plug configurado e ativo
- ✅ 17 plugins instalados e carregados
- ✅ Sistema de gerenciamento funcional

### ✅ **Fase 2: Development Tools - CONCLUÍDA**
- ✅ LSP configurado para múltiplas linguagens
- ✅ Git integration completa
- ✅ Snippets e templates automáticos

### ✅ **Fase 3: Interface Moderna - CONCLUÍDA**
- ✅ vim-airline substituindo statusline manual
- ✅ DevIcons para tipos de arquivo
- ✅ Temas otimizados com transparência

### ✅ **Fase 4: Configurações por Linguagem - CONCLUÍDA**
- ✅ C/C++: cindent, 4 espaços, LSP clangd
- ✅ Python: PEP8, line at 80, LSP pylsp  
- ✅ Web: 2 espaços, Emmet, TypeScript LSP
- ✅ Markdown: wrap, spell check automático

### ✅ **Fase 5: Performance - CONCLUÍDA**
- ✅ Startup otimizado
- ✅ Plugins desnecessários desabilitados
- ✅ Timeouts configurados
- ✅ Wildignore extensivo

## 🎯 **Benefícios Esperados Pós-Melhorias**

### **Produtividade**
- ⚡ **Busca de arquivos**: FZF fuzzy search
- 🔍 **Code navigation**: LSP go-to-definition
- 📝 **Auto-completion**: Context-aware suggestions
- 🔄 **Git workflow**: Vim-fugitive integration

### **Experiência Visual**
- 🎨 **Statusline rica**: Git status, modo, encoding
- 📊 **File explorer**: Icons e syntax highlighting
- 🌈 **Better highlighting**: Language-specific colors

### **Funcionalidades Avançadas**
- ✂️ **Snippets**: Expansão automática de templates
- 📦 **Emmet**: HTML/CSS rapid development
- 🔧 **Language servers**: Real-time error detection

## ⚠️ **Advertências**

### **Compatibilidade**
- Plugins requerem Vim 8.0+ (atual: 9.1 ✅)
- LSP precisa de language servers instalados separadamente
- Alguns plugins podem conflitar com configurações manuais

### **Performance**
- Muitos plugins podem tornar o Vim mais lento
- Considerar lazy loading para plugins grandes
- Monitorar tempo de inicialização com `:startuptime`

### **Manutenção**
- Plugins precisam de atualizações regulares
- Backup da configuração antes de grandes mudanças
- Testar configurações em ambiente isolado primeiro

---

## 📚 **SEÇÃO EXPANDIDA: GUIA COMPLETO DE USO E BOAS PRÁTICAS**

### 🎯 **FILOSOFIA DO VIM E MINDSET PRODUTIVO**

#### **Os 4 Pilares da Produtividade no Vim**

1. **Modal Editing**: Separação clara entre navegação (Normal) e edição (Insert)
2. **Composição de Comandos**: Verbos + Números + Movimentos (`d3w` = delete 3 words)
3. **Repetição Inteligente**: Comando `.` repete última ação, macros para tarefas complexas
4. **Fluxo Sem Mouse**: Mãos sempre no teclado, navegação eficiente

#### **Mentalidade Correta**
```
❌ NÃO: "Como faço isso no Vim como faria em outro editor?"
✅ SIM: "Qual é a maneira mais eficiente do Vim fazer isso?"
```

### 🚀 **WORKFLOWS COMPLETOS POR TIPO DE PROJETO**

#### **1. WORKFLOW: Desenvolvimento Web Full-Stack**

**Cenário**: Criando uma aplicação React com backend Node.js

```bash
# 1. SETUP INICIAL
cd ~/workspace/projeto-web
vim .

# 2. NAVEGAÇÃO RÁPIDA ENTRE ARQUIVOS
Ctrl+P              # FZF para buscar arquivo
# Digite: App.jsx
Enter               # Abre o arquivo

# 3. SPLIT PARA TRABALHAR COM MÚLTIPLOS ARQUIVOS
:vsp server.js      # Split vertical com backend
Ctrl+L              # Navegar para painel direito
Ctrl+H              # Voltar para painel esquerdo

# 4. EDIÇÃO COM EMMET
# No arquivo App.jsx, digite:
div.container>header+main+footer
Ctrl+E,             # Expande para estrutura HTML completa

# 5. AUTOCOMPLEÇÃO INTELIGENTE
# Digite:
import { use
Ctrl+N              # Mostra sugestões (useState, useEffect, etc.)

# 6. SNIPPETS PARA COMPONENTES
# Digite:
rfce                # React Functional Component Export
Tab                 # Expande snippet
Tab                 # Navega entre placeholders

# 7. GIT WORKFLOW INTEGRADO
,gs                 # Ver status do git
# Na janela de status, pressione 's' nos arquivos para staging
,gc                 # Commit com mensagem
:wq                 # Salvar mensagem e fazer commit
,gp                 # Push para repositório
```

**Resultado**: Desenvolvimento ágil com navegação fluida entre frontend/backend.

#### **2. WORKFLOW: Desenvolvimento em C/C++ com Debugging**

**Cenário**: Desenvolvendo aplicação em C com múltiplos arquivos

```c
// main.c
#include <stdio.h>
#include "utils.h"

int main() {
    // Cursor aqui, pressione gf para ir para utils.h
    process_data();
    return 0;
}
```

**Workflow Completo**:
```vim
# 1. NAVEGAÇÃO ENTRE HEADERS E SOURCES
gf                  # Go to file under cursor (utils.h)
Ctrl+^              # Voltar para arquivo anterior

# 2. BUSCA DE SÍMBOLOS COM LSP
gd                  # Ir para definição de process_data
gr                  # Ver todas as referências
K                   # Ver documentação/signature

# 3. COMPILAÇÃO INTEGRADA
:make               # Compilar projeto
:copen              # Abrir janela de erros
]q                  # Próximo erro
[q                  # Erro anterior

# 4. DEBUGGING COM TERMDEBUG
:packadd termdebug
:Termdebug ./program
# Use comandos GDB integrados
:Break main         # Breakpoint em main
:Run                # Executar programa
:Step               # Step into
:Next               # Step over
:Finish             # Step out
:Continue           # Continuar execução

# 5. REFATORAÇÃO COM LSP
,rn                 # Renomear símbolo em todo projeto
# Digite novo nome
Enter               # Aplicar mudanças
```

#### **3. WORKFLOW: Data Science com Python**

**Cenário**: Análise de dados com pandas e visualização

```python
# analysis.py
import pandas as pd
import matplotlib.pyplot as plt
```

**Workflow Produtivo**:
```vim
# 1. EXECUTAR CÓDIGO PYTHON DIRETO DO VIM
:!python3 %         # Executar arquivo atual
:!python3 -m pytest # Rodar testes

# 2. REPL INTERATIVO
:terminal python3   # Abre terminal Python no Vim
Ctrl+W N           # Modo Normal no terminal
i                  # Voltar para modo interativo

# 3. VISUALIZAÇÃO DE DADOS
# Selecione código em modo Visual
V                  # Modo Visual Line
jjj                # Selecionar linhas
:!python3          # Executar seleção

# 4. DOCUMENTAÇÃO INLINE
# Com cursor em 'pd.DataFrame'
K                  # Ver documentação do pandas
gi                 # Ir para implementação

# 5. JUPYTER NOTEBOOKS NO VIM
:!jupyter notebook  # Abrir Jupyter
# ou usar vim-jupyter plugin para integração
```

### 💡 **TÉCNICAS AVANÇADAS DE EDIÇÃO**

#### **1. Text Objects - A Gramática do Vim**

**Conceito**: Verbos + Text Objects = Ações Poderosas

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

**Exemplos Práticos**:
```javascript
// Código original
const message = "Hello, World!";

// ci" (change inner quotes)
// Resultado: cursor dentro das aspas para reescrever

// da" (delete a quotes)  
// Resultado: const message = ;

// dit (delete inner tag) em HTML
<div>Content to delete</div>
// Resultado: <div></div>
```

#### **2. Macros - Automação de Tarefas Repetitivas**

**Cenário**: Converter lista de nomes em objetos JSON

```text
# Lista original:
John Doe
Jane Smith
Bob Johnson
```

**Gravando Macro**:
```vim
qa                  # Iniciar gravação na macro 'a'
0                   # Início da linha
i{"name": "<Esc>    # Inserir início do JSON
$a"},<Esc>          # Adicionar final
j                   # Próxima linha
q                   # Parar gravação

# Executar macro:
@a                  # Executar uma vez
10@a                # Executar 10 vezes
@@                  # Repetir última macro
```

**Resultado**:
```json
{"name": "John Doe"},
{"name": "Jane Smith"},
{"name": "Bob Johnson"},
```

#### **3. Registers - Clipboard Avançado**

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

# VER CONTEÚDO DOS REGISTERS
:registers          # Lista todos os registers
```

### 🔧 **CUSTOMIZAÇÃO E OTIMIZAÇÃO**

#### **1. Criando Comandos Personalizados**

```vim
# Adicionar ao vimrc:

" Comando para formatar JSON
command! FormatJSON %!python3 -m json.tool

" Comando para remover trailing whitespace
command! CleanWhitespace %s/\s\+$//e

" Comando para inserir timestamp
command! Timestamp put =strftime('%Y-%m-%d %H:%M:%S')

" Função para contar palavras selecionadas
function! WordCount()
    let l:s = @"
    silent exe "normal! gvy"
    let l:words = split(@", '\W\+')
    let @" = l:s
    echo 'Words: ' . len(l:words)
endfunction
vnoremap <leader>wc :call WordCount()<CR>
```

#### **2. Abbreviations para Produtividade**

```vim
" Correções automáticas
iabbrev teh the
iabbrev recieve receive
iabbrev seperate separate

" Expansões úteis
iabbrev @@ joao@example.com
iabbrev cpy Copyright 2025 João Silva, All rights reserved.
iabbrev todo TODO: <C-R>=strftime("%Y-%m-%d")<CR> - 

" Templates de código
iabbrev forloop for (int i = 0; i < n; i++) {<CR>}<Esc>O
iabbrev ifmain if __name__ == "__main__":<CR>    
```

### 📊 **DEBUGGING E TROUBLESHOOTING**

#### **1. Diagnóstico de Performance**

```vim
# MEDIR TEMPO DE STARTUP
vim --startuptime startup.log
cat startup.log | sort -k2 -rn | head -20

# PROFILE DE FUNÇÕES
:profile start profile.log
:profile func *
:profile file *
" ... executar ações lentas ...
:profile pause
:noautocmd qall!

# VERIFICAR PLUGINS LENTOS
:PlugStatus         # Ver status dos plugins
:PlugClean          # Remover plugins não usados
```

#### **2. Resolução de Problemas Comuns**

**Problema: Vim lento ao abrir arquivos grandes**
```vim
" Solução: Desabilitar features para arquivos grandes
autocmd BufReadPre * if getfsize(expand("%")) > 10000000 | syntax off | endif

" Alternativa: Usar LargeFile plugin
Plug 'vim-scripts/LargeFile'
```

**Problema: LSP não funcionando**
```vim
" Diagnóstico:
:LspStatus          # Ver status do LSP
:LspInstallServer   # Instalar servidor para linguagem atual
:messages           # Ver mensagens de erro

" Verificar logs:
:echo lsp#get_server_status()
```

**Problema: Caracteres especiais não aparecem**
```vim
" Verificar encoding:
:set encoding?
:set fileencoding?

" Solução:
set encoding=utf-8
set fileencoding=utf-8
```

### 🎮 **ATALHOS E COMANDOS RÁPIDOS - CHEAT SHEET**

#### **Navegação Ultra-Rápida**
```vim
# MOVIMENTOS PRECISOS
f{char}             # Find: pula para próximo {char}
t{char}             # Till: pula até antes do {char}
F{char}             # Find backwards
T{char}             # Till backwards
;                   # Repetir último f/t/F/T
,                   # Repetir último f/t/F/T reverso

# NAVEGAÇÃO POR PALAVRAS
w                   # Próxima palavra
b                   # Palavra anterior
e                   # Final da palavra
W/B/E               # Versões que ignoram pontuação

# NAVEGAÇÃO POR LINHAS
0                   # Início absoluto da linha
^                   # Primeiro caractere não-branco
$                   # Final da linha
g_                  # Último caractere não-branco

# NAVEGAÇÃO POR PARÁGRAFOS/BLOCOS
{                   # Parágrafo anterior
}                   # Próximo parágrafo
%                   # Matching bracket/parentheses
[{                  # Início do bloco
]}                  # Final do bloco
```

#### **Edição Eficiente**
```vim
# INSERÇÃO INTELIGENTE
A                   # Append no final da linha
I                   # Insert no início da linha
o                   # Nova linha abaixo
O                   # Nova linha acima
ea                  # Append no final da palavra

# MODIFICAÇÃO RÁPIDA
C                   # Change até final da linha
D                   # Delete até final da linha
S                   # Substituir linha inteira
cc                  # Change linha inteira
dd                  # Delete linha inteira

# CASE MANIPULATION
~                   # Toggle case do caractere
gu{motion}          # Lowercase
gU{motion}          # Uppercase
g~{motion}          # Toggle case

# INDENTAÇÃO
>>                  # Indentar linha
<<                  # Desindentar linha
>}                  # Indentar parágrafo
=}                  # Auto-indentar parágrafo
gg=G                # Auto-indentar arquivo todo
```

### 🏆 **BEST PRACTICES E RECOMENDAÇÕES**

#### **1. Organização de Configuração**

```vim
" Estrutura recomendada para vimrc grande:
~/.vim/
├── vimrc                 # Arquivo principal
├── config/
│   ├── plugins.vim       # Configuração de plugins
│   ├── mappings.vim      # Mapeamentos customizados
│   ├── functions.vim     # Funções auxiliares
│   └── autocmds.vim      # Autocommands
└── after/
    └── ftplugin/         # Configs específicas por tipo
        ├── python.vim
        ├── javascript.vim
        └── markdown.vim
```

#### **2. Backup e Versionamento**

```bash
# Script de backup automático
#!/bin/bash
# backup-vim-config.sh

BACKUP_DIR="$HOME/backups/vim"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/vim-config-$DATE.tar.gz" \
    ~/.vim \
    ~/.vimrc \
    ~/config/vimrc \
    ~/config/vim-*.md

echo "Backup criado: vim-config-$DATE.tar.gz"

# Manter apenas últimos 10 backups
ls -t "$BACKUP_DIR"/*.tar.gz | tail -n +11 | xargs -r rm
```

#### **3. Sincronização Entre Máquinas**

```bash
# Usando Git para sincronizar configurações
cd ~/config
git init
git add vimrc vim-*.md
git commit -m "Vim configuration"
git remote add origin git@github.com:usuario/dotfiles.git
git push -u origin main

# Em outra máquina:
git clone git@github.com:usuario/dotfiles.git ~/config
ln -s ~/config/vimrc ~/.vimrc
```

### 🚨 **TROUBLESHOOTING AVANÇADO**

#### **Diagnóstico Completo do Sistema**

```bash
#!/bin/bash
# vim-health-check.sh

echo "=== VIM HEALTH CHECK ==="
echo ""

echo "1. Versão do Vim:"
vim --version | head -1

echo -e "\n2. Features compiladas:"
vim --version | grep -E "\+python3?|\+ruby|\+lua"

echo -e "\n3. Plugins instalados:"
ls ~/.vim/plugged 2>/dev/null | wc -l

echo -e "\n4. LSP Servers disponíveis:"
which clangd pylsp typescript-language-server 2>/dev/null

echo -e "\n5. Tamanho do vimrc:"
wc -l ~/config/vimrc

echo -e "\n6. Tempo de startup:"
vim --startuptime /tmp/vim-startup.log +qall
echo "Tempo total: $(tail -1 /tmp/vim-startup.log | awk '{print $1}')ms"

echo -e "\n7. Verificação de erros:"
vim -c ':messages' -c ':q' 2>&1 | grep -E "Error|Warning"
```

### 📈 **MÉTRICAS DE PRODUTIVIDADE**

#### **Medindo Sua Evolução**

```vim
" Adicionar ao vimrc para tracking de comandos
autocmd CmdlineEnter * let g:cmdline_time = reltime()
autocmd CmdlineLeave * echom 'Comando levou: ' . 
    \ reltimestr(reltime(g:cmdline_time)) . ' segundos'

" Contador de salvamentos
let g:save_count = 0
autocmd BufWritePost * let g:save_count += 1
command! SaveStats echo 'Arquivos salvos nesta sessão: ' . g:save_count

" Tempo na sessão
autocmd VimEnter * let g:session_start = localtime()
command! SessionTime echo 'Tempo de sessão: ' . 
    \ (localtime() - g:session_start) / 60 . ' minutos'
```

### 🎓 **RECURSOS DE APRENDIZADO**

#### **Progressão Recomendada**

1. **Semana 1-2: Fundamentos**
   - Dominar hjkl para navegação
   - Usar apenas modo Normal e Insert
   - Praticar :w, :q, :wq

2. **Semana 3-4: Eficiência Básica**
   - Aprender text objects (iw, i", i()
   - Usar visual mode para seleções
   - Dominar búferes e splits

3. **Mês 2: Produtividade**
   - Configurar e usar FZF
   - Aprender macros básicas
   - Integrar Git workflow

4. **Mês 3: Maestria**
   - Configurar LSP para suas linguagens
   - Criar snippets personalizados
   - Desenvolver workflow próprio

#### **Exercícios Práticos Diários**

```vim
" DIA 1: Navegação sem setas
" Desafio: Editar arquivo usando apenas hjkl
" Meta: 0 uso de setas em 1 hora

" DIA 2: Text Objects
" Desafio: Fazer 10 edições usando ci", di(, ciw
" Meta: Reduzir keystrokes em 50%

" DIA 3: Macros
" Desafio: Converter CSV para JSON usando macro
" Meta: Processar 100 linhas em < 1 minuto

" DIA 4: Búferes
" Desafio: Trabalhar com 5 arquivos sem tabs
" Meta: Navegar entre buffers fluidamente

" DIA 5: Refatoração
" Desafio: Renomear variável em 10 arquivos
" Meta: Usar LSP ou busca/substituição global
```

### 🔮 **FUTURO E EVOLUÇÃO**

#### **Próximas Melhorias Sugeridas**

1. **Integração com AI**
   ```vim
   " GitHub Copilot
   Plug 'github/copilot.vim'
   
   " ChatGPT integration
   Plug 'CoderCookE/vim-chatgpt'
   ```

2. **Debugging Avançado**
   ```vim
   " DAP (Debug Adapter Protocol)
   Plug 'puremourning/vimspector'
   ```

3. **Testing Integration**
   ```vim
   " Vim-test para rodar testes
   Plug 'vim-test/vim-test'
   ```

4. **Database Integration**
   ```vim
   " Dadbod para queries SQL
   Plug 'tpope/vim-dadbod'
   Plug 'kristijanhusak/vim-dadbod-ui'
   ```

---

**📅 Criado**: 06/08/2025  
**🔄 Última atualização**: 18/08/2025  
**🎯 Status**: ✅ **DOCUMENTAÇÃO EXPANDIDA** - Guia completo com exemplos práticos, workflows e best practices  
**📍 Localização**: `/home/joao/config/vimrc` (520 linhas, +208% melhorias)
**🚀 Comandos**: `vim-diag` para diagnóstico | `vim /home/joao/config/vim-quick-guide.md` para uso rápido | `vim /home/joao/config/vim-README.md` para guia completo

