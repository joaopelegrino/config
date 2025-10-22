# CLAUDE.md
This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive development environment configuration repository for WSL2 Ubuntu 24.04, containing centralized dotfiles, Vim configurations, shell setups, and development tools. The repository implements a centralized configuration architecture where all dotfiles are stored in `/home/notebook/config/` and linked to their standard locations via symlinks.

## Key Commands

### Development Environment
```bash
# Environment diagnostics
./diagnostico-ambiente.sh    # Full WSL environment diagnosis (20+ components)
./vim-diagnostic.sh         # Detailed Vim configuration diagnosis
reload                     # Reload shell configurations (alias)

# Vim configuration management
./sync-vim-config.sh       # Sync complete Vim structure to ~/config/
ved                       # Edit vimrc (alias)
vim-diag                  # Run Vim diagnostics (alias)

# Shell configuration
zed                       # Edit zshrc (alias)
source ~/.zshrc           # Reload Zsh configuration

# Development workflows
y                         # Open Yazi file manager
yy [path]                 # Open Yazi with cd integration
```

### Git Operations
```bash
# Remote management (uses tokens from ~/.env)
remoteadd <repo-name>          # Add remote with GitHub token
remoteadd_personal <repo-name> # Add personal remote
sync_repos [message]           # Push to multiple remotes

# Standard Git aliases (from zshrc)
gst                       # git status -sb
gco                       # git checkout  
gcm                       # git commit -m
glog                      # git log --oneline --graph --decorate
```

### Common Tasks
```bash
# Build and test (adapt to project needs)
# No standardized build system - check individual project README files
# Common patterns: make, meson/ninja, npm scripts

# Development containers
docker-compose -f docker-compose.dev.yml up  # If present in project
```

### Claude Code Integration
```bash
# Custom slash commands available in VS Code
/vscode-context    # Comprehensive VS Code setup context (extensions, paths, integrations)
                   # Use when requesting VS Code improvements or troubleshooting

# Claude Code configuration
~/.claude/commands/              # Custom slash commands
~/.claude/settings.local.json    # Permissions and preferences

# VS Code Extensions (22 total)
# - VSCodeVim v1.31.0 (full Vim emulation with centralized vimrc)
# - Claude Code, Copilot, Rust Analyzer, Remote Development, etc.
# - Managed via chezmoi: ~/.vscode-server/extensions.txt
```

## Architecture and Structure

### Configuration Architecture
- **Centralized Configuration**: All dotfiles stored in `/home/notebook/config/`
- **Symlink Strategy**: System dotfiles (`~/.vimrc`, `~/.zshrc`, etc.) are symlinks to config directory
- **Version Control**: Entire configuration is git-tracked for reproducibility
- **Backup Strategy**: Automated backup creation before major changes

### Key Directories
```
/home/notebook/config/          # Central configuration repository
├── README.md                   # Comprehensive environment documentation
├── vimrc                      # Vim configuration (520+ lines, 17 plugins)
├── zshrc                      # Zsh configuration with Oh My Zsh
├── gitconfig                  # Git global configuration
├── vim/                       # Complete Vim plugin structure
│   ├── autoload/             # vim-plug plugin manager
│   ├── plugged/              # 17 installed plugins
│   └── vsnip/                # Custom snippets
├── diagnostico-ambiente.sh    # Environment diagnosis script
├── vim-diagnostic.sh         # Vim-specific diagnosis
└── sync-vim-config.sh        # Vim synchronization script
```

### Vim Plugin Ecosystem (17 plugins)
**Navigation & Search:**
- fzf + fzf.vim (fuzzy finding)
- Key bindings: `Ctrl+P` (files), `Ctrl+B` (buffers), `Ctrl+F` (ripgrep)

**Development Tools:**
- vim-lsp + vim-lsp-settings (LSP support)
- vim-fugitive (Git integration)
- nerdcommenter (commenting)
- vim-surround (text manipulation)

**Interface:**
- vim-airline + themes (status line)
- vim-devicons (file icons)

**Code Completion:**
- vim-vsnip + vim-vsnip-integ + friendly-snippets

**Language Support:**
- emmet-vim (HTML/CSS)
- dockerfile.vim (Docker)
- typescript-vim (TypeScript)

### Shell Configuration
- **Primary Shell**: Zsh with Oh My Zsh
- **Theme**: Powerlevel10k with instant prompt
- **Key Plugins**: git, zsh-autosuggestions, z (navigation), zsh-syntax-highlighting, zsh-autocomplete
- **SSH Agent**: Persistent SSH agent configuration
- **FZF Integration**: Advanced fuzzy finding with custom configurations

### Development Tools
- **File Manager**: Yazi (Rust-based) with terminal integration
- **Git**: Version 2.43.0 with extensive aliases and helper functions
- **Container Support**: Docker Desktop integration with WSL2
- **Build Systems**: Supports Make, Meson/Ninja, CMake
- **Languages**: Python 3.12.3, Node.js 22.15.0 (via NVM), GCC 13.3.0

## Important Files

### Configuration Files
- `/home/notebook/config/vimrc` - Main Vim configuration (520+ lines)
- `/home/notebook/config/zshrc` - Zsh shell configuration with Oh My Zsh
- `/home/notebook/config/gitconfig` - Git global settings
- `/home/notebook/config/README.md` - Comprehensive environment documentation

### Diagnostic Scripts
- `/home/notebook/config/diagnostico-ambiente.sh` - Full environment health check
- `/home/notebook/config/vim-diagnostic.sh` - Vim-specific diagnostics
- `/home/notebook/config/sync-vim-config.sh` - Vim configuration synchronization

### Environment Files
- `~/.env` - Contains tokens and secrets (NOT version controlled)
- `~/.p10k.zsh` - Powerlevel10k theme configuration

## Development Patterns

### Vim Workflow
1. Use `Ctrl+P` for file navigation
2. `Ctrl+F` for project-wide text search
3. Git integration via vim-fugitive (`,gs` for status, `,gc` for commit)
4. LSP support for C, Python, TypeScript development

### C Development Workflows and Advanced Use Cases

#### LSP-Powered C Development
The environment includes **clangd** LSP server providing enterprise-grade C development features:

**Navigation Workflow:**
```vim
gd          " Go to definition (functions, variables, types)
gr          " Find all references across entire project
gi          " Go to implementation
gt          " Go to type definition
K           " Show documentation/hover info
```

**Code Intelligence:**
```vim
<leader>rn  " Intelligent rename across project
[g / ]g     " Navigate diagnostics (errors/warnings)
:LspStatus  " Check language server status
:LspHover   " Manual documentation lookup
```

#### Advanced C Project Patterns

**Large Codebase Navigation:**
1. **Project-wide Symbol Search**: `Ctrl+F` → search for function/variable names
2. **Header File Discovery**: `Ctrl+P` → type `.h` to filter headers
3. **Source-Header Toggle**: Use `:edit %<.h` or `:edit %<.c` pattern
4. **Cross-Reference Analysis**: `gr` on any symbol shows usage patterns

**Debugging and Analysis Workflow:**
```bash
# Build with debug symbols
make CFLAGS="-g -O0 -Wall -Wextra"

# In Vim - check compiler diagnostics
:LspDocumentDiagnostics  # Show all file issues
[g                       # Jump to first error
]g                       # Jump to next error
```

**Multi-File Refactoring Example:**
```vim
# Scenario: Rename function across 50+ files
1. Place cursor on function name
2. <leader>rn             # LSP rename
3. Type new name
4. LSP automatically updates all references
5. :wa                   # Save all modified files
```

#### Build System Integration

**Makefile Projects:**
```bash
# From Vim command line
:!make                   # Build project
:!make clean             # Clean build
:!make test              # Run tests
:copen                   # Open quickfix for errors
```

**CMake Projects:**
```bash
# Initial setup
mkdir build && cd build
cmake ..

# From Vim
:!cmake --build ../build
:!cd ../build && make test
```

**Meson/Ninja Projects:**
```bash
# Setup
meson setup builddir

# Build from Vim
:!ninja -C builddir
:!cd builddir && meson test
```

#### Memory Management and Static Analysis

**Integration with Analysis Tools:**
```bash
# Valgrind integration
:!valgrind --leak-check=full ./program

# Static analysis with clang-tidy
:!clang-tidy *.c -- -I./include

# Address sanitizer build
:!make CFLAGS="-fsanitize=address -g"
```

**Code Quality Workflow:**
1. **Lint on Save**: clangd provides real-time linting
2. **Format Code**: Use clang-format integration
3. **Memory Check**: Valgrind commands through Vim terminal
4. **Security Scan**: Static analysis tools via `:!` commands

#### Advanced Vim Features for C

**Snippet-Driven Development:**
```vim
# Common C snippets (via vsnip)
main<Tab>     # Main function template
func<Tab>     # Function template
struct<Tab>   # Struct definition
if<Tab>       # If statement
for<Tab>      # For loop
```

**Multi-File Session Management:**
```vim
# Save session for complex projects
:mksession! project.vim

# Restore session
vim -S project.vim

# Buffer management for large projects
:ls           # List all buffers
:b main.c     # Switch to main.c buffer
:bd           # Delete current buffer
```

**Advanced Git Integration for C Projects:**
```vim
<leader>gd    # Git diff - see changes in split view
<leader>gl    # Git log - view commit history
:Gblame       # See line-by-line git blame
:Gwrite       # Stage current file
```

#### Real-World C Development Scenarios

**Scenario 1: Debugging Segmentation Fault**
```vim
1. :!gdb ./program
2. In GDB: run, bt, print variables
3. Back to Vim: navigate to problematic line
4. Use K for documentation
5. Check pointer usage with gr (references)
```

**Scenario 2: Adding New Feature to Legacy Codebase**
```vim
1. Ctrl+F → search for similar functionality
2. gd on function names to understand structure
3. gr to see usage patterns
4. Create new function following existing patterns
5. Use <leader>rn if refactoring is needed
```

**Scenario 3: Performance Optimization**
```vim
1. :!perf record ./program
2. :!perf report
3. Navigate to hot functions using Ctrl+P
4. Analyze with LSP hover (K) for complexity
5. Use gr to understand call patterns
```

**Scenario 4: Cross-Platform Development**
```vim
1. Use conditional compilation checking
2. Ctrl+F to find #ifdef patterns
3. LSP diagnostics for platform-specific issues
4. Build testing: :!make linux && make windows
```

### Project Structure Conventions
- Configuration changes should be made in `/home/notebook/config/`
- Use diagnostic scripts before and after major changes
- Run `reload` after shell configuration changes
- Use `sync-vim-config.sh` when modifying Vim setup

### Security Practices
- Tokens and secrets stored in `~/.env` (not version controlled)
- SSH agent configured for persistent key management
- Git configured with proper user identity and signing

## Testing and Validation

### Health Checks
```bash
./diagnostico-ambiente.sh    # Comprehensive environment check (20+ tests)
./vim-diagnostic.sh         # Vim configuration validation
```

### Common Troubleshooting
- **Plugin Issues**: Run `:PlugStatus` in Vim, then `:PlugUpdate` if needed
- **LSP Problems**: Check `:LspStatus` in Vim
- **Shell Issues**: Run `reload` to refresh configuration
- **Symlink Problems**: Check diagnostic scripts for broken links

### Performance Monitoring
- Shell startup time should be <500ms
- Vim should load in <2 seconds with all plugins
- Use diagnostic scripts to identify performance issues

This configuration represents a mature, production-ready development environment optimized for productivity and maintainability.
