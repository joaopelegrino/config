# Paths de Configuração do Ambiente WSL2

**Formato:** Compatível com Windows Explorer e aplicações Windows
**Distro:** Ubuntu-24.04
**Usuário WSL:** notebook
**Usuário Windows:** valor

---

## Configuração Central (Chezmoi)

| Descrição | Path Windows |
|-----------|--------------|
| **Chezmoi Source** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.local\share\chezmoi` |
| **Chezmoi Config** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.config\chezmoi` |

---

## Dotfiles e Shell

| Descrição | Path Windows |
|-----------|--------------|
| **Configuração Central** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\config` |
| **Zshrc** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.zshrc` |
| **Vimrc** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vimrc` |
| **Gitconfig** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.gitconfig` |
| **Oh My Zsh** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.oh-my-zsh` |
| **Powerlevel10k** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.p10k.zsh` |

---

## VS Code (WSL Server)

| Descrição | Path Windows |
|-----------|--------------|
| **VS Code Server** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vscode-server` |
| **Extensions** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vscode-server\extensions` |
| **User Settings** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vscode-server\data\Machine\settings.json` |
| **Snippets** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.config\Code\User\snippets` |

---

## Claude Code

| Descrição | Path Windows |
|-----------|--------------|
| **Claude Config** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.claude` |
| **Slash Commands** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.claude\commands` |
| **Settings** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.claude\settings.local.json` |
| **CLAUDE.md Global** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.claude\CLAUDE.md` |

---

## Vim

| Descrição | Path Windows |
|-----------|--------------|
| **Vim Plugins** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vim\plugged` |
| **Vim Autoload** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vim\autoload` |
| **Vim Snippets** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.vim\vsnip` |

---

## Windows Terminal

| Descrição | Path |
|-----------|------|
| **Settings (Windows)** | `C:\Users\valor\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json` |
| **Source (WSL)** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.config\windows-terminal\settings.json` |

> **Nota:** Arquivo é COPIADO do WSL para Windows via chezmoi (Windows não suporta symlinks WSL)

---

## Ferramentas de Desenvolvimento

| Descrição | Path Windows |
|-----------|--------------|
| **ASDF** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.asdf` |
| **NVM** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.nvm` |
| **Cargo (Rust)** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.cargo` |
| **SSH Keys** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.ssh` |
| **Environment (.env)** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\.env` |

---

## Workspace

| Descrição | Path Windows |
|-----------|--------------|
| **Workspace Principal** | `\\wsl.localhost\Ubuntu-24.04\home\notebook\workspace` |

---

## Acesso Rápido via Windows Explorer

Para acessar qualquer path acima:
1. Pressione `Win + R`
2. Cole o path desejado
3. Pressione Enter

Ou no Windows Explorer, cole na barra de endereços.

---

## Paths Linux Equivalentes

| Windows Path Base | Linux Path |
|-------------------|------------|
| `\\wsl.localhost\Ubuntu-24.04\home\notebook` | `/home/notebook` |
| `\\wsl.localhost\Ubuntu-24.04\home\notebook\.local\share\chezmoi` | `~/.local/share/chezmoi` |
| `\\wsl.localhost\Ubuntu-24.04\home\notebook\.config` | `~/.config` |

---

*Gerado em: 2025-11-21*
