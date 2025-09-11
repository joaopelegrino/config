# Guia do Terminal Integrado do Vim

## Status da Configuração

### ✅ Suporte Habilitado

Seu Vim tem **pleno suporte** ao terminal integrado:
- **Versão**: Vim 9.1 (2024)
- **Recurso**: `+terminal` está **ativado** na compilação
- **Recursos relacionados**: `+termguicolors`, `+terminfo`, `+termresponse` também habilitados

### 📋 Configurações Atuais no vimrc

**Configurações que afetam o terminal integrado:**

1. **Cores do terminal** (linhas 11-15):
   ```vim
   if has('termguicolors')
       set termguicolors    " True color support
   else
       set t_Co=256         " 256 colors fallback
   endif
   ```

2. **Mouse desabilitado** (linha 528):
   ```vim
   set mouse=    " Previne interferência com aplicações de terminal
   ```

3. **Bells desabilitados** (linhas 4-8):
   ```vim
   set belloff=all
   set novisualbell
   set t_vb=
   set noerrorbells
   set vb t_vb=
   ```

## 🚀 Comandos de Uso

### Comandos Básicos

| Comando | Descrição |
|---------|-----------|
| `:term` | Abre terminal em split horizontal |
| `:vert term` | Abre terminal em split vertical |
| `:term ++rows=10` | Abre terminal com altura específica |
| `:term ++cols=80` | Abre terminal com largura específica |
| `:term bash` | Abre bash específico |
| `:term ++close` | Fecha janela quando terminal sair |
| `:term ++kill=term` | Mata processo ao fechar |

### Navegação entre Modos

| Ação | Comando |
|------|---------|
| **Modo Terminal → Normal** | `Ctrl+W N` ou `Ctrl+\ Ctrl+N` |
| **Modo Normal → Terminal** | `i` ou `a` |
| **Navegação entre splits** | `Ctrl+h/j/k/l` (já configurado) |

## 🔧 Mapeamentos Recomendados

Adicione estas linhas ao seu `vimrc` para melhor experiência:

```vim
" =============================================================================
" TERMINAL INTEGRADO - Mapeamentos adicionais
" =============================================================================

" Atalhos para abrir terminal
nnoremap <leader>t :term<CR>
nnoremap <leader>vt :vert term<CR>

" Sair do modo terminal facilmente
tnoremap <Esc> <C-\><C-n>

" Navegação entre splits no modo terminal
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k  
tnoremap <C-w>l <C-\><C-n><C-w>l

" Redimensionar splits no modo terminal
tnoremap <C-w>+ <C-\><C-n><C-w>+
tnoremap <C-w>- <C-\><C-n><C-w>-
tnoremap <C-w>< <C-\><C-n><C-w><
tnoremap <C-w>> <C-\><C-n><C-w>>
```

## 💡 Casos de Uso Práticos

### 1. Desenvolvimento com Git
```vim
:term                    " Abrir terminal
git status               " Verificar status
git add .                " Adicionar arquivos
git commit -m "mensagem" " Fazer commit
```

### 2. Execução de Scripts
```vim
:term python script.py   " Executar script Python
:term node app.js        " Executar aplicação Node.js
:term make               " Executar Makefile
```

### 3. Monitoramento de Logs
```vim
:term tail -f /var/log/app.log
```

### 4. Terminal Temporário
```vim
:term ++close            " Terminal que fecha automaticamente
```

## 🔄 Integração com Workflow Atual

### Compatibilidade com Plugins Existentes

- **FZF**: Comandos `Ctrl+P`, `Ctrl+F` funcionam normalmente
- **vim-fugitive**: Git integration funciona no terminal integrado  
- **LSP**: Suporte LSP funciona em arquivos abertos via terminal
- **Clipboard WSL2**: Integração com Windows clipboard mantida

### Fluxo de Trabalho Sugerido

1. **Editor Principal**: Use Vim para edição de código
2. **Terminal Integrado**: Use `:term` para comandos rápidos
3. **Navegação**: Use `Ctrl+h/j/k/l` para alternar entre editor e terminal
4. **Git**: Use vim-fugitive para Git ou terminal para comandos complexos

## 🎯 Dicas de Produtividade

### Atalhos Úteis (com leader=",")

| Atalho | Ação |
|--------|------|
| `,t` | Abrir terminal horizontal |
| `,vt` | Abrir terminal vertical |
| `Esc` | Sair do modo terminal |
| `,w` | Salvar arquivo atual |
| `,q` | Fechar janela atual |

### Comandos de Sistema Úteis

```bash
# No terminal integrado:
./diagnostico-ambiente.sh    # Diagnóstico completo do ambiente
./vim-diagnostic.sh         # Diagnóstico específico do Vim
reload                      # Recarregar configurações do shell
y                          # Abrir Yazi (file manager)
```

## 🛠️ Troubleshooting

### Problemas Comuns

1. **Terminal não abre**:
   - Verifique: `:echo has('terminal')`
   - Deveria retornar `1`

2. **Cores incorretas**:
   - Verifique: `:echo &termguicolors`
   - Use `:set termguicolors!` para alternar

3. **Não consegue sair do modo terminal**:
   - Use: `Ctrl+\ Ctrl+N`
   - Ou adicione o mapeamento `tnoremap <Esc> <C-\><C-n>`

4. **Navegação entre splits não funciona**:
   - Verifique se os mapeamentos `Ctrl+h/j/k/l` estão configurados
   - Adicione os mapeamentos para modo terminal

### Verificação da Configuração

```vim
" Comandos para verificar status:
:echo has('terminal')        " Deve retornar 1
:echo &termguicolors        " Mostra se true colors estão ativos  
:echo &mouse                " Deve estar vazio para melhor compatibilidade
:version                    " Mostra recursos compilados (+terminal)
```

## 📚 Referências

- **Arquivo de configuração**: `/home/notebook/config/vimrc`
- **Documentação do Vim**: `:help terminal`
- **Diagnósticos**: `./vim-diagnostic.sh`
- **Ambiente**: `./diagnostico-ambiente.sh`

---

**Última atualização**: 2025-09-09  
**Versão do Vim**: 9.1 com suporte completo a terminal integrado