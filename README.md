# 🔧 Dotfiles & Configurações

Repositório centralizado de configurações para ambiente de desenvolvimento Linux/WSL2.

## 📁 Estrutura

```
config/
├── vim/                 # Configuração completa do Vim
│   ├── autoload/       # Plugin manager (vim-plug)
│   ├── spell/          # Dicionários de correção
│   ├── undodir/        # Histórico de desfazer persistente
│   └── vsnip/          # Snippets personalizados
├── vimrc               # Arquivo principal de configuração do Vim
├── bashrc              # Configuração do Bash
├── zshrc               # Configuração do Zsh
├── gitconfig           # Configuração global do Git
├── sync-vim-config.sh  # Script de sincronização do Vim
└── README.md           # Este arquivo
```

## 🚀 Instalação Rápida

### Clone o repositório
```bash
git clone https://github.com/wmogh/config.git ~/config
```

### Configure o Vim
```bash
cd ~/config
./sync-vim-config.sh
```

Este script irá:
- ✅ Criar links simbólicos `~/.vim` → `~/config/vim`
- ✅ Criar link simbólico `~/.vimrc` → `~/config/vimrc`
- ✅ Fazer backup de configurações existentes
- ✅ Instalar o vim-plug automaticamente

### Instale os plugins do Vim
Abra o Vim e execute:
```vim
:PlugInstall
```

## 📦 Componentes

### Vim
- **Plugin Manager**: vim-plug
- **Principais Plugins**:
  - `fzf` - Fuzzy finder
  - `vim-airline` - Barra de status
  - `vim-fugitive` - Integração Git
  - `vim-lsp` - Language Server Protocol
  - `nerdcommenter` - Comentários rápidos
  - `vim-surround` - Manipulação de delimitadores
  - `emmet-vim` - Expansão HTML/CSS

### Shell
- **Zsh**: Configuração com Oh My Zsh e Powerlevel10k
- **Bash**: Configuração básica com aliases úteis

### Git
- Aliases personalizados
- Configuração de cores
- Editor padrão: Vim

## 🔄 Sincronização

### Atualizar configurações locais
```bash
cd ~/config
git pull origin main
```

### Enviar alterações
```bash
cd ~/config
git add .
git commit -m "feat: descrição das alterações"
git push origin main
```

## 🛠️ Scripts Úteis

### sync-vim-config.sh
Script para sincronizar configuração do Vim entre `~/.vim` e `~/config/vim`.

**Uso**:
```bash
./sync-vim-config.sh
```

**Funcionalidades**:
- Cria backup automático de configurações existentes
- Copia estrutura completa do Vim para ~/config
- Estabelece links simbólicos
- Verifica integridade da configuração

## 📝 Personalização

### Adicionar novos plugins do Vim
1. Edite `vimrc`
2. Adicione a linha do plugin na seção `call plug#begin()`
3. Execute `:PlugInstall` no Vim

### Modificar atalhos
Edite `vimrc` e procure pela seção de mapeamentos (mappings).

## 🔒 Segurança

O arquivo `.gitignore` está configurado para excluir:
- Arquivos temporários e de swap
- Histórico de comandos
- Arquivos de sessão
- Plugins (serão baixados pelo vim-plug)
- Backups automáticos

## 📊 Status do Repositório

- **Versionamento Local**: ✅ Git configurado
- **Versionamento Remoto**: ✅ GitHub (https://github.com/wmogh/config)
- **Backup Automático**: ✅ Script de sincronização com timestamps

## 🤝 Contribuindo

Para adicionar novas configurações:
1. Teste localmente
2. Commite com mensagens descritivas
3. Use conventional commits (feat:, fix:, docs:, etc.)

## 📚 Documentação Adicional

- `vim-README.md` - Guia completo do Vim
- `vim-quick-guide.md` - Referência rápida de comandos
- `vim-diagnostic.sh` - Script de diagnóstico

## 📧 Contato

Repositório mantido por @wmogh

---

*Última atualização: Agosto 2025*
