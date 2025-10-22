# VS Code Setup Guide - Ultrathink Environment

**Quick reference guide for VS Code configuration managed by chezmoi**

---

## 🚀 Quick Start

### 1. Initial Setup (Already Done ✅)

All configurations have been applied to your system:
- ✅ Settings (machine-specific, templated)
- ✅ Keybindings (Vim-compatible)
- ✅ Snippets (Rust, Python, Markdown)
- ✅ Extension manager
- ✅ Documentation

### 2. Verify Installation

```bash
# Check if all files were applied
ls -lah ~/.vscode-server/data/Machine/settings.json
ls -lah ~/.config/Code/User/keybindings.json
ls -lah ~/.config/Code/User/snippets/

# Check extension manager
~/.vscode-server/manage-extensions.sh help
```

### 3. Install Extensions

```bash
# Recommended: Use the management script
~/.vscode-server/manage-extensions.sh install

# Or sync (install missing, optionally remove extra)
~/.vscode-server/manage-extensions.sh sync

# Check what's different
~/.vscode-server/manage-extensions.sh diff
```

### 4. Reload VS Code

After applying configurations:
- Press `Ctrl+Shift+P`
- Type "Developer: Reload Window"
- Press Enter

---

## 📁 File Structure

| File | Purpose | Location |
|------|---------|----------|
| **settings.json** | Machine-specific settings | `~/.vscode-server/data/Machine/` |
| **keybindings.json** | Custom keybindings | `~/.config/Code/User/` |
| **snippets/*.json** | Code snippets | `~/.config/Code/User/snippets/` |
| **extensions.txt** | Extension list | `~/.vscode-server/` |
| **manage-extensions.sh** | Extension manager | `~/.vscode-server/` |
| **README.md** | Full documentation | `~/.vscode-server/` |

---

## ⚙️ Settings Highlights

### Vim Integration
```json
{
    "vim.leader": ",",
    "vim.vimrc.path": "/home/notebook/vimrc"
}
```
**Uses your existing centralized vimrc!**

### Template Files
```json
{
    "files.associations": {
        ".chezmoi*.yaml": "helm",
        "*.tmpl": "gotmpl"
    }
}
```
**Syntax highlighting for chezmoi templates!**

### Language-Specific
- **Rust**: Auto-format on save, Clippy checks
- **Python**: 79/120 character rulers, 4-space tabs
- **Markdown**: Word wrap, KaTeX math support
- **YAML**: 2-space indentation

### WSL2 Optimized
```json
{
    "files.watcherUsePolling": true,
    "search.followSymlinks": false
}
```
**Better performance in WSL2!**

---

## ⌨️ Key Keybindings

| Shortcut | Action | Context |
|----------|--------|---------|
| `Ctrl+Shift+C` | Open Claude Code | Editor |
| `Ctrl+Shift+A` | Add to Claude Context | Editor |
| `Alt+\` | GitHub Copilot Generate | No selection |
| `Ctrl+I` | Inline Suggest | Editor |
| `Ctrl+.` | Quick Fix | Code actions |
| `F2` | Rename Symbol | Rename available |
| `Ctrl+Shift+G` | Git View | - |
| `Ctrl+Shift+D` | Docker View | - |
| `Ctrl+Shift+F` | Find in Files | - |
| `Ctrl+\`` | Toggle Terminal | - |

**All keybindings are Vim-safe!**

---

## 📝 Snippets Reference

### Rust
- `main` - Main function
- `testmod` - Test module
- `asyncfn` - Async function
- `tokiotest` - Tokio test
- `struct` - Struct with Debug
- `impl` - Implementation block

### Python
- `ifmain` - Main guard
- `dataclass` - Dataclass
- `asyncdef` - Async function
- `pytest` - Pytest test
- `pydantic` - Pydantic model
- `logger` - Logger setup

### Markdown
- `code` - Code block
- `note` - GitHub note alert
- `warning` - GitHub warning
- `table` - Markdown table
- `mermaid` - Mermaid diagram
- `frontmatter` - YAML front matter

---

## 🔧 Common Tasks

### Modify Settings

```bash
# Method 1: Edit with chezmoi
chezmoi edit ~/.vscode-server/data/Machine/settings.json

# Method 2: Direct edit + re-add
vim ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl
chezmoi apply

# Verify template rendering
chezmoi execute-template < ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl
```

### Add New Extension

```bash
# 1. Install in VS Code (GUI or CLI)
code --install-extension publisher.extension-name

# 2. Add to extensions.txt
echo "publisher.extension-name" >> ~/.local/share/chezmoi/dot_vscode-server/extensions.txt

# 3. Version control
chezmoi add ~/.vscode-server/extensions.txt
chezmoi cd && git commit -m "feat(vscode): add new extension"
```

### Create Custom Snippet

```bash
# 1. Create snippet file
vim ~/.local/share/chezmoi/dot_config/Code/User/snippets/javascript.json

# 2. Add to chezmoi
chezmoi add ~/.config/Code/User/snippets/javascript.json

# 3. Apply
chezmoi apply
```

### Sync Extensions Across Machines

```bash
# On machine A (after installing new extensions)
~/.vscode-server/manage-extensions.sh export

# Review and merge into extensions.txt
# Commit to git

# On machine B (pull latest dotfiles)
chezmoi update
~/.vscode-server/manage-extensions.sh install
```

---

## 🐛 Troubleshooting

### Settings Not Applied

```bash
# Force re-apply
chezmoi apply --force ~/.vscode-server/data/Machine/settings.json

# Reload VS Code
# Ctrl+Shift+P → "Developer: Reload Window"
```

### Extension Script Not Found

```bash
# Make sure it's executable
chmod +x ~/.vscode-server/manage-extensions.sh

# Or re-apply from chezmoi
chezmoi apply ~/.vscode-server/manage-extensions.sh
```

### 'code' Command Not Found

```bash
# WSL: Add to PATH
export PATH="$PATH:/mnt/c/Users/YOUR_USER/AppData/Local/Programs/Microsoft VS Code/bin"

# Add to ~/.zshrc permanently
echo 'export PATH="$PATH:/mnt/c/Users/YOUR_USER/AppData/Local/Programs/Microsoft VS Code/bin"' >> ~/.zshrc
```

### Vim Integration Not Working

```bash
# Check vimrc exists
ls -la ~/vimrc

# Should be symlink to /home/notebook/config/vimrc
# If not:
ln -sf /home/notebook/config/vimrc ~/vimrc
```

### Chezmoi Template Errors

```bash
# Test template rendering
chezmoi execute-template < ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl

# Check for syntax errors in template
vim ~/.local/share/chezmoi/dot_vscode-server/data/Machine/settings.json.tmpl
```

---

## 📚 Full Documentation

For complete documentation, see:
- **Full README**: `~/.vscode-server/README.md`
- **Extension Manager Help**: `~/.vscode-server/manage-extensions.sh help`
- **Chezmoi Docs**: `~/.local/share/chezmoi/README-DOTFILES.md`
- **Environment Docs**: `~/.local/share/chezmoi/CLAUDE.md`
- **VS Code Context**: `~/.claude/commands/vscode-context.md`

---

## 🎯 Next Steps

### Recommended Actions:

1. **Install Helm Intellisense Extension**
   ```bash
   code --install-extension Tim-Koehler.helm-intellisense
   ```
   **Why:** Syntax highlighting for chezmoi templates (`.chezmoi*.yaml`)

2. **Consider VSCodeVim Extension**
   ```bash
   code --install-extension vscodevim.vim
   ```
   **Why:** Full Vim emulation in VS Code (alternative to machine settings)

3. **Set Up Settings Sync** (Optional)
   - Use VS Code's built-in Settings Sync for GUI preferences
   - Keep critical configs in chezmoi dotfiles
   - Best of both worlds!

4. **Commit to Git**
   ```bash
   chezmoi cd
   git add dot_vscode-server/ dot_config/Code/
   git commit -m "feat(vscode): complete VS Code configuration with chezmoi

   - Templated settings.json with Vim integration
   - Custom keybindings (Claude Code, Copilot, Vim-safe)
   - Snippets for Rust, Python, Markdown
   - Extension management automation
   - Comprehensive documentation"
   git push
   ```

---

## 🔄 Workflow Example

### Daily Development

1. **Morning**: Open VS Code
   - Settings auto-loaded from chezmoi
   - Extensions already installed
   - Vim integration works out of the box

2. **During Development**: Use snippets
   - Type `main` + Tab in Rust file → Main function
   - Type `pytest` + Tab in Python → Test template
   - Type `code` + Tab in Markdown → Code block

3. **Git Integration**: Use keybindings
   - `Ctrl+Shift+G` → Git view
   - `Ctrl+.` → Quick fixes
   - `F2` → Rename across files

4. **AI Assistance**: Toggle assistants
   - `Ctrl+Shift+C` → Claude Code chat
   - `Alt+\` → Copilot suggestion

5. **End of Day**: Sync changes
   ```bash
   # If you modified settings in VS Code GUI
   chezmoi re-add ~/.vscode-server/data/Machine/settings.json
   chezmoi cd && git commit -m "chore(vscode): update settings"
   ```

### New Machine Setup

1. **Install chezmoi** + clone dotfiles
2. **Apply VS Code configs**:
   ```bash
   chezmoi apply
   ```
3. **Install extensions**:
   ```bash
   ~/.vscode-server/manage-extensions.sh install
   ```
4. **Open VS Code** → Everything works!

---

**Generated:** 2025-10-22
**Environment:** ultrathink (WSL2 Ubuntu 24.04)
**Managed by:** chezmoi
**Status:** ✅ Fully Configured
