#!/bin/bash

# Exit on error
set -e

echo "Updating system and installing packages..."
# List of packages to install
PACKAGES=(
    neovim
    base-devel
    cmake
    unzip
    nodejs
    npm
    python-pynvim
    python-pip
    xclip
    wl-clipboard
    luarocks
    php
    composer
    sqlite
    tree-sitter
    ttf-firacode-nerd
    lazygit
    zoxide
    fzf
    starship
    ripgrep
    fd
    bat
    eza
    lazydocker
    tmux
    dbeaver
    zsh-antidote
)

# Install packages using yay
yay -S --needed --noconfirm "${PACKAGES[@]}"

echo "Configuring Antidote plugins..."
PLUGIN_FILE="$HOME/.zsh_plugins.txt"
cat <<EOF > "$PLUGIN_FILE"
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
zsh-users/zsh-syntax-highlighting
EOF

echo "Configuring NPM global packages..."
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"

echo "Configuring .zshrc..."
ZSHRC="$HOME/.zshrc"

# Ensure .zshrc exists
touch "$ZSHRC"

# Add Antidote, Starship, Zoxide, FZF, and NPM configuration to .zshrc
# We use a marker to avoid duplicate entries if the script is run multiple times
if ! grep -q "### ARCH SETUP CONFIG ###" "$ZSHRC"; then
    cat <<EOF >> "$ZSHRC"

### ARCH SETUP CONFIG ###

# NPM Global Packages
export PATH="\$HOME/.npm-global/bin:\$PATH"

# Antidote
source /usr/share/zsh-antidote/antidote.zsh
antidote load

# Starship
eval "\$(starship init zsh)"

# Zoxide
eval "\$(zoxide init zsh)"

# FZF with fd and bat
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="\$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'

# Aliases for suggested upgrades
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias cat='bat'
alias docker-ui='lazydocker'

### END ARCH SETUP CONFIG ###
EOF
fi

echo "Applying Starship 'pastel-powerline' preset..."
mkdir -p "$HOME/.config"
starship preset pastel-powerline -o "$HOME/.config/starship.toml"

echo "Setup complete! Please restart your terminal or run 'source ~/.zshrc'."
