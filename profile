# ~/.profile: executado pelo bash e zsh para shells de login
# Este arquivo é carregado apenas uma vez por sessão de login

# Configurações de ambiente globais
export EDITOR=vim
export BROWSER=wslview

# Adicionar ~/.local/bin ao PATH se não estiver presente
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Configurações WSL específicas
if grep -q "microsoft" /proc/version 2>/dev/null; then
    export WSL=1
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi
# Carregar Cargo (Rust) se disponível
[[ -f "$HOME/.cargo/env" ]] && 