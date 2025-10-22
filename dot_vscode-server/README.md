# VS Code Configuration with Chezmoi

Comprehensive VS Code configuration management for the ultrathink WSL2 environment, managed via chezmoi for reproducibility across machines.

## 📋 Table of Contents

- [Overview](#overview)
- [Structure](#structure)
- [Installation](#installation)
- [Configuration Files](#configuration-files)
- [Extension Management](#extension-management)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

---

## Overview

This directory contains all VS Code configurations managed by chezmoi:

- **Machine-specific settings** (templated)
- **Keybindings** (custom shortcuts)
- **Snippets** (Rust, Python, Markdown)
- **Extension list** (reproducible setup)
- **Automation scripts** (extension management)

### Why Chezmoi for VS Code?

✅ **Reproducible**: Same config across machines
✅ **Templated**: Machine-specific values (paths, usernames)
✅ **Versioned**: Track changes in git
✅ **Automated**: Scripts for extension management
✅ **Documented**: Clear structure and usage

---

## Structure

```
dot_vscode-server/
├── README.md                              # This file
├── data/
│   └── Machine/
│       └── settings.json.tmpl             # Machine-specific settings (templated)
├── extensions.txt                         # List of extensions to install
└── executable_manage-extensions.sh        # Extension management script

dot_config/Code/User/
├── keybindings.json                       # Custom keybindings
└── snippets/
    ├── rust.json                          # Rust snippets
    ├── python.json                        # Python snippets
    └── markdown.json                      # Markdown snippets
```

### File Locations (After Apply)

| Source (Chezmoi) | Target (System) |
|------------------|-----------------|
| `dot_vscode-server/data/Machine/settings.json.tmpl` | `~/.vscode-server/data/Machine/settings.json` |
| `dot_config/Code/User/keybindings.json` | `~/.config/Code/User/keybindings.json` |
| `dot_config/Code/User/snippets/*.json` | `~/.config/Code/User/snippets/*.json` |
| `dot_vscode-server/extensions.txt` | `~/.vscode-server/extensions.txt` |
| `dot_vscode-server/executable_manage-extensions.sh` | `~/.vscode-server/manage-extensions.sh` |

---

## Installation

### 1. Apply Chezmoi Configurations

```bash
# Apply all VS Code configurations
chezmoi apply

# Or apply specific files
chezmoi apply ~/.vscode-server/data/Machine/settings.json
chezmoi apply ~/.config/Code/User/keybindings.json
```

### 2. Install Extensions

```bash
# Method 1: Using the management script (recommended)
~/.vscode-server/manage-extensions.sh install

# Method 2: Manual installation
cat ~/.vscode-server/extensions.txt | grep -v '^#' | grep -v '^$' | xargs -L 1 code --install-extension
```

### 3. Reload VS Code

- Press `Ctrl+Shift+P` → "Developer: Reload Window"
- Or restart VS Code

---

## Configuration Files

### settings.json.tmpl

**Location:** `~/.vscode-server/data/Machine/settings.json`

**Features:**
- ✅ Templated paths (uses `{{ .chezmoi.username }}`)
- ✅ Vim integration (references centralized vimrc)
- ✅ WSL2-optimized file watchers
- ✅ Language-specific settings (Rust, Python, Markdown, YAML, JSON)
- ✅ Extension configurations (Claude Code, Copilot, Rust Analyzer)
- ✅ Chezmoi template file associations (`.chezmoi*.yaml` → helm)

**Template Variables:**
```json
{
    "vim.vimrc.path": "/home/{{ .chezmoi.username }}/vimrc"
    // Resolves to: "/home/notebook/vimrc" on your system
}
```

### keybindings.json

**Location:** `~/.config/Code/User/keybindings.json`

**Key Bindings:**

| Shortcut | Command | Context |
|----------|---------|---------|
| `Ctrl+Shift+C` | Open Claude Code Chat | Editor focus |
| `Ctrl+Shift+A` | Add to Claude Context | Editor focus |
| `Alt+\` | GitHub Copilot Generate | No selection |
| `Ctrl+I` | Trigger Inline Suggest | Editor focus |
| `Ctrl+.` | Quick Fix | Code actions available |
| `F2` | Rename Symbol | Rename provider |
| `Ctrl+Shift+G` | Git View | - |
| `Ctrl+Shift+D` | Docker View | - |

**All keybindings are Vim-compatible** (safe to use with Vim mode enabled).

### Snippets

**Location:** `~/.config/Code/User/snippets/`

#### Rust Snippets (`rust.json`)
- `main` - Main function
- `testmod` - Test module
- `derive` - Derive macro
- `result` - Result type
- `asyncfn` - Async function
- `tokiotest` - Tokio async test
- `struct` - Struct with Debug derive
- `impl` - Implementation block

#### Python Snippets (`python.json`)
- `ifmain` - Main guard
- `dataclass` - Dataclass definition
- `asyncdef` - Async function with type hints
- `pytest` - Pytest test function
- `pydantic` - Pydantic model
- `logger` - Logger setup

#### Markdown Snippets (`markdown.json`)
- `code` - Code block
- `task` - Task list item
- `table` - Markdown table
- `note` - GitHub-style note alert
- `warning` - GitHub-style warning alert
- `mermaid` - Mermaid diagram
- `frontmatter` - YAML front matter

---

## Extension Management

### Management Script

**Location:** `~/.vscode-server/manage-extensions.sh`

**Commands:**

```bash
# Install all extensions from list
./manage-extensions.sh install

# Export currently installed extensions
./manage-extensions.sh export

# Sync extensions (install missing, optionally remove extra)
./manage-extensions.sh sync

# Show difference between installed and listed
./manage-extensions.sh diff
```

### Extensions List

**Location:** `~/.vscode-server/extensions.txt`

**Categories:**
1. **AI/Productivity**: Claude Code, Copilot, CodeRabbit
2. **Development Tools**: Code Runner, Dependi
3. **Remote Development**: WSL, SSH, Containers
4. **Container/Kubernetes**: Docker, K8s Tools
5. **Language Support**: Rust Analyzer, YAML, Markdown

**Maintaining the List:**

```bash
# Add a new extension
echo "publisher.extension-name" >> ~/.vscode-server/extensions.txt

# Then apply with chezmoi
chezmoi add ~/.vscode-server/extensions.txt
```

---

## Customization

### Modifying Settings

1. **Edit the source file:**
   ```bash
   # For machine-specific settings
   chezmoi edit ~/.vscode-server/data/Machine/settings.json

   # Or edit directly
   vim ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl
   ```

2. **Apply changes:**
   ```bash
   chezmoi apply ~/.vscode-server/data/Machine/settings.json
   ```

3. **Commit to git:**
   ```bash
   chezmoi cd
   git add dot_vscode-server/
   git commit -m "feat(vscode): update settings"
   git push
   ```

### Adding Custom Snippets

1. **Create snippet file:**
   ```bash
   vim ~/.local/share/chezmoi/dot_config/Code/User/snippets/javascript.json
   ```

2. **Apply with chezmoi:**
   ```bash
   chezmoi add ~/.config/Code/User/snippets/javascript.json
   chezmoi apply
   ```

### Template Variables

Available chezmoi variables in `settings.json.tmpl`:

| Variable | Example Value | Usage |
|----------|---------------|-------|
| `{{ .chezmoi.username }}` | `notebook` | User paths |
| `{{ .chezmoi.hostname }}` | `DESKTOP-...` | Hostname |
| `{{ .chezmoi.os }}` | `linux` | OS-specific settings |
| `{{ .chezmoi.arch }}` | `amd64` | Architecture |
| `{{ .chezmoi.homeDir }}` | `/home/notebook` | Home directory |

**Example:**
```json
{
    "myExtension.dataPath": "{{ .chezmoi.homeDir }}/data"
}
```

---

## Troubleshooting

### Settings Not Applying

**Problem:** Changes to settings.json.tmpl don't appear in VS Code.

**Solution:**
```bash
# 1. Check if template renders correctly
chezmoi execute-template < ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl

# 2. Force apply
chezmoi apply --force ~/.vscode-server/data/Machine/settings.json

# 3. Reload VS Code
# Press Ctrl+Shift+P → "Developer: Reload Window"
```

### Extension Installation Fails

**Problem:** `manage-extensions.sh install` fails.

**Solution:**
```bash
# 1. Check if 'code' command exists
which code

# 2. If not found, add to PATH (WSL)
export PATH="$PATH:/mnt/c/Users/YOUR_USER/AppData/Local/Programs/Microsoft VS Code/bin"

# 3. Try manual installation
code --install-extension extensionid
```

### Symlinks vs. Copies

**Important:** Chezmoi creates **copies**, not symlinks by default.

If you want to edit settings directly in VS Code and have changes reflected in chezmoi:

```bash
# Option 1: Use chezmoi edit
chezmoi edit ~/.vscode-server/data/Machine/settings.json

# Option 2: Edit target, then re-add to chezmoi
vim ~/.vscode-server/data/Machine/settings.json
chezmoi re-add ~/.vscode-server/data/Machine/settings.json
```

### Vim Integration Not Working

**Problem:** Vim keybindings not working in VS Code.

**Check:**
1. Verify vimrc path in settings.json:
   ```json
   "vim.vimrc.path": "/home/notebook/vimrc"
   ```

2. Check if vimrc exists:
   ```bash
   ls -la ~/vimrc
   ```

3. Install VSCodeVim extension (if not using machine settings):
   ```bash
   code --install-extension vscodevim.vim
   ```

### Chezmoi Template Syntax Highlighting

**Problem:** No syntax highlighting for `.tmpl` files.

**Solution:**
Install Helm Intellisense extension and add to settings.json:
```json
"files.associations": {
    ".chezmoi*.yaml": "helm",
    "*.tmpl": "gotmpl"
}
```

---

## Best Practices

### 1. **Separate Machine-Specific Settings**

✅ **Do:** Use templates for paths, usernames, OS-specific settings
❌ **Don't:** Hardcode absolute paths

```json
// ✅ Good
"terminal.integrated.shell.linux": "/usr/bin/zsh"

// ❌ Bad
"myExtension.path": "/home/notebook/data"  // Use template instead
```

### 2. **Version Control Extension List**

✅ **Do:** Keep `extensions.txt` updated
❌ **Don't:** Manually install extensions without updating the list

```bash
# After installing a new extension in VS Code
code --list-extensions > /tmp/current-extensions.txt
# Review and add to extensions.txt
```

### 3. **Document Custom Settings**

✅ **Do:** Add comments explaining non-obvious settings
❌ **Don't:** Leave cryptic configuration without context

```json
{
    // WSL2-specific: Use polling due to filesystem limitations
    "files.watcherUsePolling": true
}
```

### 4. **Test Before Committing**

✅ **Do:** Apply and test changes before committing
❌ **Don't:** Commit untested templates

```bash
# Test template rendering
chezmoi execute-template < ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl

# Apply and test
chezmoi apply
# Open VS Code and verify settings work

# Then commit
chezmoi cd && git add . && git commit -m "feat(vscode): add new settings"
```

### 5. **Use Extension Categories**

✅ **Do:** Organize `extensions.txt` with comments
❌ **Don't:** Have an unorganized list

```txt
# === AI/Productivity ===
anthropic.claude-code
github.copilot

# === Language Support ===
rust-lang.rust-analyzer
```

### 6. **Keep Snippets Simple**

✅ **Do:** Create focused, reusable snippets
❌ **Don't:** Create overly complex snippets

```json
{
    "Simple Test": {
        "prefix": "test",
        "body": ["#[test]", "fn $1() {", "    $0", "}"]
    }
}
```

---

## Additional Resources

- **Chezmoi Documentation:** https://www.chezmoi.io/
- **VS Code Settings Reference:** https://code.visualstudio.com/docs/getstarted/settings
- **VS Code Keybindings:** https://code.visualstudio.com/docs/getstarted/keybindings
- **Snippet Syntax:** https://code.visualstudio.com/docs/editor/userdefinedsnippets

- **Ultrathink Environment:**
  - Main docs: `~/.local/share/chezmoi/README-DOTFILES.md`
  - Development workflows: `~/.local/share/chezmoi/CLAUDE.md`
  - Claude Code context: `~/.claude/commands/vscode-context.md`

---

## Changelog

### 2025-10-22 - Initial Setup
- ✅ Created templated settings.json with Vim integration
- ✅ Added comprehensive keybindings (Claude Code, Copilot, Vim-safe)
- ✅ Created snippets for Rust, Python, Markdown
- ✅ Implemented extension management script
- ✅ Documented all configurations and best practices

---

**Generated:** 2025-10-22
**Environment:** ultrathink (WSL2 Ubuntu 24.04)
**Managed by:** chezmoi
