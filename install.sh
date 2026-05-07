#!/bin/sh

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

echo "🚀 Stowing dotfiles..."

# Stow everything under ~/.config
if [ -d "$DOTFILES_DIR/config" ]; then
    echo "📂 Stowing config files to ~/.config"
    stow -v -t "$HOME/.config" config
    stow -v -t "$HOME/.config" wallpapers
fi

# Stow everything under ~/.themes
if [ -d "$DOTFILES_DIR/themes" ]; then
    echo "🎨 Stowing themes to ~/.local/share/themes"
    stow -v -t "$HOME/.local/share/themes" themes
fi

if [ -d "$DOTFILES_DIR/zsh" ]; then
    echo "🎨 Stowing vim and zsh to ~"
    stow -v -t "$HOME" zsh 
    stow -v -t "$HOME" vim
fi

echo "🎉 All dotfiles successfully stowed!"

