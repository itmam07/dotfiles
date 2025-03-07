#!/bin/bash

# Define the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

# Ensure the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "❌ Error: Directory $DOTFILES_DIR does not exist. Exiting..."
    exit 1
fi

# Check if `stow` is installed
if ! command -v stow &>/dev/null; then
    echo "🛠️ Installing GNU Stow..."
    sudo pacman -S --noconfirm stow
else
    echo "✅ GNU Stow is already installed."
fi

echo "🚀 Removing stowed dotfiles..."

# Unstow everything under ~/.config
if [ -d "$DOTFILES_DIR/config" ]; then
    echo "📂 Unstowing config files from ~/.config"
    stow -v -D -t "$HOME/.config" config
fi

# Unstow everything under ~/.themes
if [ -d "$DOTFILES_DIR/themes" ]; then
    echo "🎨 Unstowing themes from ~/.themes"
    stow -v -D -t "$HOME/.themes" themes
fi

# Unstow home directory files like .zshrc
echo "🏠 Unstowing home directory files..."
stow -v -D -t "$HOME" zsh starship

echo "✅ All dotfiles successfully unstowed!"

