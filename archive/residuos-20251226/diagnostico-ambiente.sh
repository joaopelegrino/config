#!/bin/bash

# Script de diagnóstico completo do ambiente WSL
set -e

CONFIG_DIR="$HOME/config"
WORKSPACE_DIR="$HOME/workspace"

echo "========================================="
echo "🔍 Diagnóstico do Ambiente WSL"
echo "========================================="
echo "Data: $(date)"
echo "Usuário: $USER"
echo "Diretório atual: $(pwd)"
echo ""

# Função para verificar se um comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Função para verificar links simbólicos
check_symlink() {
    local file="$1"
    local description="$2"
    
    if [ -L "$file" ]; then
        local target=$(readlink "$file")
        echo "✅ $description: $file → $target"
        if [ ! -e "$target" ]; then
            echo "   ⚠️  Alvo do link não existe!"
        fi
    elif [ -e "$file" ]; then
        echo "⚠️  $description: $file existe mas não é um link simbólico"
    else
        echo "❌ $description: $file não encontrado"
    fi
}

echo "## 1. Verificação do Sistema"
echo "WSL Version: $(cat /proc/version | grep -o "WSL[0-9]*")"
echo "Kernel: $(uname -r)"
echo "Distribuição: $(lsb_release -d | cut -f2)"
echo "Arquitetura: $(uname -m)"
echo ""

echo "## 2. Links Simbólicos dos Dotfiles"
check_symlink "$HOME/.bashrc" "Bashrc"
check_symlink "$HOME/.gitconfig" "Git Config"
check_symlink "$HOME/.profile" "Profile"
check_symlink "$HOME/.vimrc" "Vimrc"
check_symlink "$HOME/.vim" "Vim Directory"
check_symlink "$HOME/.fzf.zsh" "FZF Zsh"
check_symlink "$HOME/.fzf.bash" "FZF Bash"
echo ""

echo "## 3. Estrutura de Diretórios"
echo "📁 Estrutura do Config:"
if [ -d "$CONFIG_DIR" ]; then
    echo "✅ $CONFIG_DIR existe"
    echo "   Arquivos: $(ls -1 $CONFIG_DIR | wc -l)"
    ls -la "$CONFIG_DIR" | head -10
else
    echo "❌ $CONFIG_DIR não encontrado"
fi
echo ""

echo "📁 Estrutura do Workspace:"
if [ -d "$WORKSPACE_DIR" ]; then
    echo "✅ $WORKSPACE_DIR existe"
    echo "   Subdiretórios: $(find $WORKSPACE_DIR -maxdepth 1 -type d | wc -l)"
    ls -la "$WORKSPACE_DIR"
else
    echo "❌ $WORKSPACE_DIR não encontrado"
fi
echo ""

echo "## 4. Ferramentas de Desenvolvimento"
tools=(
    "git:Git"
    "vim:Vim"
    "node:Node.js"
    "python3:Python3"
    "gcc:GCC"
    "cmake:CMake"
    "docker:Docker"
)

for tool_desc in "${tools[@]}"; do
    tool="${tool_desc%%:*}"
    desc="${tool_desc##*:}"
    
    if command_exists "$tool"; then
        version=$($tool --version 2>/dev/null | head -1 | cut -d' ' -f1-3)
        echo "✅ $desc: $version"
    else
        echo "❌ $desc não encontrado"
    fi
done
echo ""

echo "## 5. Configuração do VSCode"
if [ -d "$WORKSPACE_DIR/.vscode" ]; then
    echo "✅ Diretório .vscode existe"
    echo "   Arquivos de configuração:"
    ls -la "$WORKSPACE_DIR/.vscode"
    
    # Verificar tasks.json
    if [ -f "$WORKSPACE_DIR/.vscode/tasks.json" ]; then
        echo "✅ tasks.json configurado"
        echo "   Tarefas definidas: $(grep -c "\"label\"" "$WORKSPACE_DIR/.vscode/tasks.json")"
    else
        echo "❌ tasks.json não encontrado"
    fi
    
    # Verificar settings.json
    if [ -f "$WORKSPACE_DIR/.vscode/settings.json" ]; then
        echo "✅ settings.json configurado"
    else
        echo "❌ settings.json não encontrado"
    fi
else
    echo "❌ Diretório .vscode não encontrado em $WORKSPACE_DIR"
fi
echo ""

echo "## 6. Plugins do Vim"
if [ -d "$HOME/.vim/plugged" ]; then
    echo "✅ Diretório de plugins existe"
    plugin_count=$(ls -1 "$HOME/.vim/plugged" | wc -l)
    echo "   Plugins instalados: $plugin_count"
    ls -1 "$HOME/.vim/plugged" | head -5
    [ $plugin_count -gt 5 ] && echo "   ... e mais $(($plugin_count - 5)) plugins"
else
    echo "❌ Diretório de plugins não encontrado"
fi
echo ""

echo "## 7. Integração com Windows Terminal"
echo "📄 Configurações do Windows Terminal:"
if [ -f "$CONFIG_DIR/windows-terminal-settings.json" ]; then
    echo "✅ Arquivo de configuração encontrado"
    
    # Verificar perfil WSL
    if grep -q "Ubuntu WSL" "$CONFIG_DIR/windows-terminal-settings.json"; then
        echo "✅ Perfil Ubuntu WSL configurado"
    else
        echo "⚠️  Perfil Ubuntu WSL não encontrado na configuração"
    fi
    
    # Verificar startingDirectory
    if grep -q "//wsl\$/Ubuntu/home" "$CONFIG_DIR/windows-terminal-settings.json"; then
        echo "✅ Diretório inicial WSL configurado"
    else
        echo "⚠️  Diretório inicial WSL não configurado corretamente"
    fi
    
    # Verificar fonte Nerd Font
    if grep -q "Hack Nerd Font" "$CONFIG_DIR/windows-terminal-settings.json"; then
        echo "✅ Fonte Nerd Font configurada"
    else
        echo "⚠️  Fonte Nerd Font não configurada"
    fi
else
    echo "❌ Arquivo de configuração do Windows Terminal não encontrado"
fi
echo ""

echo "## 8. Configurações do VSCode para WSL"
echo "📄 Configurações VSCode:"
if [ -f "$CONFIG_DIR/vscode-settings.json" ]; then
    echo "✅ Arquivo de configuração encontrado"
    
    # Verificar configurações WSL específicas
    if grep -q "wsl.localhost" "$CONFIG_DIR/vscode-settings.json"; then
        echo "✅ Configuração de UNC hosts para WSL encontrada"
    else
        echo "⚠️  Configuração de UNC hosts para WSL não encontrada"
    fi
    
    # Verificar execução em WSL
    if grep -q "executeInWSL.*true" "$CONFIG_DIR/vscode-settings.json"; then
        echo "✅ Execução de containers em WSL configurada"
    else
        echo "⚠️  Execução de containers em WSL não configurada"
    fi
    
    # Verificar terminal font
    if grep -q "Hack Nerd Font" "$CONFIG_DIR/vscode-settings.json"; then
        echo "✅ Fonte do terminal configurada"
    else
        echo "⚠️  Fonte do terminal não configurada"
    fi
else
    echo "❌ Arquivo de configuração do VSCode não encontrado"
fi
echo ""

echo "## 9. Testes de Funcionalidade"
echo "🧪 Testando funcionalidades básicas:"

# Testar FZF
if [ -f "$HOME/.fzf/bin/fzf" ]; then
    echo "✅ FZF instalado e disponível"
    echo "   Versão: $($HOME/.fzf/bin/fzf --version)"
else
    echo "❌ FZF não disponível"
fi

# Testar Vim com plugins
if command_exists vim; then
    echo "✅ Vim disponível"
    if vim --cmd 'echo "Vim funcionando"' --cmd 'qall!' >/dev/null 2>&1; then
        echo "✅ Vim inicializa corretamente"
    else
        echo "⚠️  Vim tem problemas na inicialização"
    fi
else
    echo "❌ Vim não disponível"
fi

echo ""

echo "## 10. Resumo de Status"
echo "========================================="
echo "📊 Resumo do Diagnóstico:"
echo ""

# Contar sucessos
success_count=0
total_checks=20

[ -L "$HOME/.bashrc" ] && ((success_count++))
[ -L "$HOME/.gitconfig" ] && ((success_count++))
[ -L "$HOME/.vimrc" ] && ((success_count++))
[ -L "$HOME/.vim" ] && ((success_count++))
[ -d "$CONFIG_DIR" ] && ((success_count++))
[ -d "$WORKSPACE_DIR" ] && ((success_count++))
[ -d "$WORKSPACE_DIR/.vscode" ] && ((success_count++))
[ -f "$WORKSPACE_DIR/.vscode/tasks.json" ] && ((success_count++))
[ -f "$WORKSPACE_DIR/.vscode/settings.json" ] && ((success_count++))
[ -d "$HOME/.vim/plugged" ] && ((success_count++))
command_exists git && ((success_count++))
command_exists vim && ((success_count++))
command_exists node && ((success_count++))
command_exists python3 && ((success_count++))
command_exists gcc && ((success_count++))
[ -f "$HOME/.fzf/bin/fzf" ] && ((success_count++))
[ -f "$CONFIG_DIR/windows-terminal-settings.json" ] && ((success_count++))
[ -f "$CONFIG_DIR/vscode-settings.json" ] && ((success_count++))
grep -q "Ubuntu WSL" "$CONFIG_DIR/windows-terminal-settings.json" 2>/dev/null && ((success_count++))
grep -q "wsl.localhost" "$CONFIG_DIR/vscode-settings.json" 2>/dev/null && ((success_count++))

percentage=$((success_count * 100 / total_checks))

echo "✅ Configurações funcionais: $success_count/$total_checks ($percentage%)"
echo ""

if [ $percentage -ge 90 ]; then
    echo "🎉 Ambiente está bem configurado!"
elif [ $percentage -ge 70 ]; then
    echo "⚠️  Ambiente parcialmente configurado. Algumas melhorias necessárias."
else
    echo "❌ Ambiente precisa de configuração adicional."
fi

echo ""
echo "## Para resolver problemas:"
echo "1. Execute: source ~/.bashrc"
echo "2. Reinstale plugins do Vim: vim +PlugInstall +qall"
echo "3. Verifique configurações do Windows Terminal"
echo "4. Sincronize dotfiles: cd ~/config && git pull"
echo ""
echo "========================================="
echo "🏁 Diagnóstico concluído!"
echo "========================================="
