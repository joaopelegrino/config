# Workspace - Documentação Geral

## Visão Geral

Este workspace está organizado para separar projetos de **aprendizado** de projetos em **produção**, cada um com suas próprias convenções de documentação.

## Estrutura Principal

```
workspace/
├── learning/       # Projetos de aprendizado e experimentação
├── rodando/        # Projetos em produção/publicados
├── ambiente.md     # Configuração do ambiente de desenvolvimento
└── README.md       # Este arquivo
```

## Pasta `learning/` - Aprendizado

### Propósito
Todos os projetos em fase de aprendizado, experimentação e desenvolvimento de habilidades.

### Estrutura
```
learning/
├── material_estudo/         # Documentação e estudos
│   ├── DD-MM/              # Trabalho diário (ex: 25-07)
│   ├── projetos/           # Definições de projetos
│   ├── topicos/            # Conhecimento por tema
│   └── fornecedores/       # Informações de serviços
├── projetos_c/             # Projetos C de aprendizado
│   └── Saas-Comunicacao-Saude/
└── site_wm/                # Outros projetos de estudo
```

### Convenções de Documentação
- ✅ Usar método texto sintético com tags PT-BR
- ✅ Documentar sessões de aprendizado detalhadas
- ✅ Incluir checklists incrementais
- ✅ Tags recomendadas:
  ```markdown
  <!-- CONTEXTO:tema:subtema -->
  <!-- BUSCA:conceito_principal -->
  <!-- SECAO:INICIO:nome -->
  <!-- PRIORIDADE:alta -->
  <!-- REF_CRUZADA:tipo:nome -> caminho -->
  ```

### Exemplo de Documentação
```markdown
# Sessão de Aprendizado: [Tema]
<!-- CONTEXTO:aprendizado:c_basico -->
<!-- BUSCA:servidor_http -->

## Objetivo
Construir servidor HTTP simples para entender sockets

<!-- SECAO:INICIO:implementacao -->
## Implementação Passo a Passo
...
<!-- SECAO:FIM:implementacao -->
```

## Pasta `rodando/` - Produção

### Propósito
Projetos finalizados que estão em produção, com repositórios remotos ou deploy ativo.

### Convenções de Documentação
- ❌ NÃO usar tags de texto sintético
- ✅ Usar documentação padrão de mercado
- ✅ README.md limpo e profissional
- ✅ Compatível com GitHub/GitLab

### Exemplo de Documentação
```markdown
# Nome do Projeto

## Descrição
Breve descrição do projeto e seu propósito.

## Instalação
```bash
git clone https://github.com/usuario/projeto
cd projeto
make install
```

## Uso
Instruções de uso...
```

## Fluxo de Trabalho

1. **Nova Ideia** → `learning/material_estudo/DD-MM/ideia.md`
2. **Desenvolvimento** → `learning/[nome_projeto]/`
3. **Documentação** → `learning/material_estudo/{projetos,topicos}/`
4. **Produção** → `rodando/[nome_projeto]/`

## Configurações

- **Ambiente**: Ver [ambiente.md](./ambiente.md)
- **Claude Code**: Configurações em `~/.claude/`
- **VSCode**: Workspaces `.code-workspace`

## Comandos Úteis

### Criar novo projeto de aprendizado
```bash
cd ~/workspace/learning
mkdir novo_projeto
cd novo_projeto
# Usar tags de texto sintético na documentação
```

### Mover projeto para produção
```bash
# Remover tags de texto sintético
# Criar README.md padrão
cp -r ~/workspace/learning/projeto ~/workspace/rodando/
```

## Links Importantes

- [Método Texto Sintético](./learning/material_estudo/topicos/estrutura_arquivos/prompt_texto_sintetico_inicial.md)
- [Comando Aprender](~/.claude/commands/aprender.md)
- [Material de Estudo](./learning/material_estudo/)

## Lembrete

- **learning/**: Documentação rica, tags PT-BR, foco em aprendizado
- **rodando/**: Documentação limpa, sem tags, pronto para publicar

---

*Última atualização: 25/07/2025*