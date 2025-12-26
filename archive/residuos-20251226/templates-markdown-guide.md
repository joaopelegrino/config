# Guia Completo: Templates de Arquivos Markdown (.md)

## Visão Geral

Este documento detalha o sistema completo de templates para arquivos Markdown implementado no ambiente de desenvolvimento, focando na automatização e eficiência para criação de documentos estruturados, especialmente para projetos de blog e documentação técnica.

## Arquitetura do Sistema de Templates

### Componentes Implementados

1. **Snippets do Vim** - Inserção rápida em arquivos existentes
2. **Comandos personalizados do Vim** - Criação de novos arquivos estruturados
3. **Script shell automatizado** - Geração avançada com substituições
4. **Aliases do shell** - Acesso direto aos templates base

### Estrutura de Arquivos

```
/home/notebook/config/
├── vim/vsnip/markdown.json          # Snippets do Vim
├── create-llm-template.sh           # Script de automação
├── vimrc                           # Comandos personalizados
└── zshrc                           # Aliases do shell

/home/notebook/workspace/blog/.claude/commands/
└── LLM-main.md                     # Template base de referência
```

## Método 1: Snippets do Vim

### Configuração
Localização: `/home/notebook/config/vim/vsnip/markdown.json`

### Snippets Disponíveis

#### Template Completo LLM
```json
"llm_main_template": {
  "prefix": "llm-main",
  "body": [
    "",
    "<-SESSÃO DE RESPONSABILIDADE DO USUÁRIO - APENAS PARA LEITURA->",
    "",
    "Realize a <tarefa> seguindo as <praticas>.",
    "",
    "<tarefa>",
    "",
    "$1",
    "",
    "  | Documento Original | Status | Documento Atualizado | Alinhamento |",
    "  |--------------------|--------|--------------------- |-------------|",
    "  | $2                 | $3     | $4                   | $5          |",
    // ... estrutura completa
  ]
}
```

#### Template de Tarefa
```json
"llm_task_only": {
  "prefix": "llm-task",
  "body": [
    "<tarefa>",
    "",
    "$1",
    "",
    "  | Documento Original | Status | Documento Atualizado | Alinhamento |",
    "  |--------------------|--------|--------------------- |-------------|",
    "  | $2                 | $3     | $4                   | $5          |",
    // ... apenas seção de tarefa
  ]
}
```

### Como Usar Snippets

1. **Em qualquer arquivo .md no Vim:**
   ```vim
   llm-main<Tab>    " Insere template completo
   llm-task<Tab>    " Insere apenas seção de tarefa
   llm-table<Tab>   " Insere tabela de status
   ```

2. **Navegação pelos campos:**
   ```vim
   <Tab>            " Próximo campo ($1 → $2 → $3...)
   <Shift+Tab>      " Campo anterior
   ```

### Vantagens dos Snippets
- ✅ **Velocidade**: Inserção instantânea
- ✅ **Flexibilidade**: Funciona em qualquer arquivo
- ✅ **Integração**: Não requer comandos externos
- ✅ **Campos editáveis**: Navegação por placeholders

## Método 2: Comandos Personalizados do Vim

### Configuração
Localização: `/home/notebook/config/vimrc`

```vim
" LLM template commands
command! LLMMain tabnew | 0r /home/notebook/workspace/blog/.claude/commands/LLM-main.md
command! -nargs=1 LLMNew tabnew <args> | 0r /home/notebook/workspace/blog/.claude/commands/LLM-main.md
```

### Como Usar

1. **Novo arquivo com template:**
   ```vim
   :LLMMain                    " Nova tab com template
   :LLMNew arquivo-projeto.md  " Arquivo específico com template
   ```

2. **Integração com abbreviações:**
   ```vim
   :LLMNew bclaude/novo-comando.md
   :LLMNew bdocs/documentacao.md
   ```

### Vantagens dos Comandos Vim
- ✅ **Criação direta**: Arquivo novo + template em um comando
- ✅ **Integração com paths**: Usa abbreviações `bclaude`, `bdocs`
- ✅ **Workflow nativo**: Funciona dentro do editor
- ✅ **Tab management**: Abre em nova tab automaticamente

## Método 3: Script Shell Automatizado

### Configuração
Localização: `/home/notebook/config/create-llm-template.sh`

### Funcionalidades do Script

```bash
#!/bin/bash
# Script para criar templates LLM-main.md com substituições automáticas
# Uso: ./create-llm-template.sh [nome-arquivo] [tarefa-descricao]

# Funcionalidades implementadas:
# - Timestamp automático
# - Substituições de conteúdo
# - Abertura automática no Vim
# - Validação de template base
```

### Como Usar

1. **Criação básica:**
   ```bash
   llm-new                     # Arquivo com timestamp
   # Resultado: LLM-20241223-1430.md
   ```

2. **Arquivo nomeado:**
   ```bash
   llm-new "analise-performance.md"
   # Resultado: analise-performance.md
   ```

3. **Com descrição personalizada:**
   ```bash
   llm-new "refactor.md" "Refatorar sistema de autenticação"
   # Substitui descrição da tarefa automaticamente
   ```

### Substituições Automáticas

O script realiza as seguintes substituições:
- **Timestamp**: Data/hora de criação
- **Descrição da tarefa**: Texto personalizado
- **Paths**: Integração com abbreviações
- **Metadados**: Comentários de criação automática

### Vantagens do Script
- ✅ **Automação avançada**: Substituições inteligentes
- ✅ **Flexibilidade**: Aceita parâmetros customizados
- ✅ **Integração terminal**: Uso direto do shell
- ✅ **Timestamp automático**: Organização temporal

## Método 4: Aliases do Shell

### Configuração
Localização: `/home/notebook/config/zshrc`

```bash
# LLM template aliases
alias llm-new='~/config/create-llm-template.sh'
alias llm-main='vim /home/notebook/workspace/blog/.claude/commands/LLM-main.md'
alias llm-copy='cp /home/notebook/workspace/blog/.claude/commands/LLM-main.md'
```

### Como Usar

1. **Acesso ao template original:**
   ```bash
   llm-main         # Edita template base no Vim
   ```

2. **Cópia rápida:**
   ```bash
   cd bclaude/commands/
   llm-copy novo-template.md
   vim novo-template.md
   ```

3. **Criação automatizada:**
   ```bash
   llm-new "projeto-x.md" "Implementar nova feature"
   ```

### Vantagens dos Aliases
- ✅ **Acesso direto**: Comandos curtos e memoráveis
- ✅ **Workflow terminal**: Integração com shell
- ✅ **Simplicidade**: Sem dependências complexas
- ✅ **Consistência**: Padrão unificado de nomes

## Integração com o Sistema FZF

### Busca de Templates

O sistema se integra com FZF para localização eficiente:

```vim
Ctrl+P              # Busca arquivos no projeto atual
Ctrl+B              # Lista templates em buffers
Ctrl+F              # Busca conteúdo em templates
```

### Comportamento do FZF por Contexto

1. **Em repositório Git:**
   - Busca: Raiz do repositório + subdiretórios
   - Ignora: Arquivos em `.gitignore`
   - Inclui: Templates tracked e untracked

2. **Fora de repositório:**
   - Busca: Diretório atual + subdiretórios
   - Escopo: Baseado no working directory do Vim

3. **Controle de escopo:**
   ```vim
   :Files bclaude/         # Busca específica em .claude
   :Files bdocs/           # Busca específica em docs
   :pwd                    # Verifica diretório atual
   ```

## Casos de Uso Práticos

### Cenário 1: Adicionando Seção em Documento Existente

```vim
# Em arquivo .md já aberto
llm-task<Tab>           # Insere seção de tarefa
# Preenche campos com Tab/Shift+Tab
```

### Cenário 2: Novo Documento Estruturado

```vim
# Método A: Via comando Vim
:LLMNew projeto-x.md

# Método B: Via script shell
llm-new "analise.md" "Analisar performance do sistema"
```

### Cenário 3: Customização de Template Base

```bash
# Edita template original
llm-main

# Cria variação personalizada
cd bclaude/templates/
llm-copy template-customizado.md
vim template-customizado.md
```

### Cenário 4: Projeto Multi-Repositório

```bash
# Templates específicos por projeto
cd /workspace/projeto-a/
llm-new "task-a.md" "Feature específica projeto A"

cd /workspace/projeto-b/
llm-new "task-b.md" "Feature específica projeto B"
```

## Configurações Avançadas

### Personalização de Snippets

Para adicionar novos snippets em `/home/notebook/config/vim/vsnip/markdown.json`:

```json
{
  "novo_template": {
    "prefix": "prefixo",
    "body": [
      "linha 1",
      "$1",
      "linha com $2 placeholder"
    ],
    "description": "Descrição do template"
  }
}
```

### Extensão do Script Shell

Para adicionar novas funcionalidades ao script:

```bash
# Adicionar validações
if [[ ! -f "$TEMPLATE_SOURCE" ]]; then
    echo "❌ Template não encontrado"
    exit 1
fi

# Adicionar substituições personalizadas
sed -i "s/PLACEHOLDER/$VARIAVEL/g" "$TARGET_FILE"
```

### Mapeamentos Adicionais no Vim

```vim
# Atalhos específicos por projeto
nnoremap <leader>lb :Files bclaude/<CR>
nnoremap <leader>ld :Files bdocs/<CR>
nnoremap <leader>lt :LLMNew
```

## Troubleshooting

### Problemas Comuns

1. **Snippets não funcionam:**
   ```vim
   :PlugStatus              # Verifica plugins
   :source ~/.vimrc         # Recarrega configuração
   ```

2. **Script sem permissão:**
   ```bash
   chmod +x ~/config/create-llm-template.sh
   ```

3. **Aliases não reconhecidos:**
   ```bash
   source ~/.zshrc          # Recarrega shell
   reload                   # Comando personalizado
   ```

4. **Template base não encontrado:**
   ```bash
   ls -la bclaude/commands/LLM-main.md
   # Verificar se arquivo existe
   ```

### Verificação de Saúde do Sistema

```bash
# Teste de componentes
llm-main                    # Deve abrir template no Vim
llm-new teste.md           # Deve criar arquivo teste
vim -c ":echo 'OK'" -c ":q" # Testa Vim

# Verificação de paths
echo $bclaude              # Deve mostrar abbreviação
ls ~/config/vim/vsnip/     # Deve mostrar markdown.json
```

## Otimizações de Performance

### Carregamento de Snippets

Os snippets são carregados automaticamente pelo vim-vsnip, sem impacto na inicialização do Vim.

### Cache de Templates

Templates frequentes ficam em buffers do Vim para acesso rápido:
```vim
:buffers                   # Lista templates carregados
Ctrl+B                     # FZF para buffers
```

### Integração com Git

Templates são automaticamente tracked se criados dentro de repositórios Git:
```bash
git status                 # Mostra novos templates
git add template.md        # Adiciona ao controle de versão
```

## Roadmap de Melhorias

### Funcionalidades Planejadas

1. **Templates dinâmicos:** Geração baseada em contexto do projeto
2. **Validação de schema:** Verificação automática de estrutura
3. **Integração com LSP:** Completion inteligente para campos
4. **Templates por filetype:** Especialização por tipo de documento
5. **Sync automático:** Sincronização entre diferentes ambientes

### Integrações Futuras

- **GitHub Actions:** Templates para CI/CD
- **Docker:** Templates para containerização
- **API Documentation:** Templates para documentação de APIs
- **Testing:** Templates para planos de teste

## Conclusão

O sistema de templates implementado oferece múltiplas camadas de automação para criação de documentos Markdown, desde inserção rápida via snippets até geração automatizada com scripts shell. Cada método tem seu caso de uso ideal:

- **Snippets:** Inserção rápida em documentos existentes
- **Comandos Vim:** Criação estruturada de novos arquivos
- **Scripts shell:** Automação avançada com substituições
- **Aliases:** Acesso direto e simplicidade

A integração com FZF, abbreviações de path e Git awareness torna o sistema altamente eficiente para workflows de desenvolvimento e documentação técnica.

---

*Documento criado automaticamente em 2024-12-23 - Sistema de Templates Markdown v1.0*