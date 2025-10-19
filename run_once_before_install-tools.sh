#!/bin/bash
# Executado UMA VEZ antes de aplicar dotfiles
# Instala ferramentas base necessárias

set -e

echo "📦 Installing base tools..."

# ==============================================================================
# MISE
# ==============================================================================
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh

    # Ativar imediatamente
    export PATH="$HOME/.local/bin:$PATH"
    eval "$(~/.local/bin/mise activate bash)"
else
    echo "✓ mise already installed"
fi

# ==============================================================================
# STARSHIP
# ==============================================================================
if ! command -v starship &> /dev/null; then
    echo "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "✓ starship already installed"
fi

# ==============================================================================
# ZSH (se não instalado)
# ==============================================================================
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    sudo apt-get update
    sudo apt-get install -y zsh
else
    echo "✓ zsh already installed"
fi

# ==============================================================================
# FZF (fuzzy finder)
# ==============================================================================
if [ ! -d "$HOME/.fzf" ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
else
    echo "✓ fzf already installed"
fi

echo "✅ Base tools installed!"
echo ""
echo "Next: chezmoi will apply dotfiles and trigger mise install"
