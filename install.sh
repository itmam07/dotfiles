#!/bin/bash

# Define the dotfiles directory and the target directory
DOTFILES_DIR="$HOME/dotfiles"
TARGET_DIR="$HOME"

# Ensure the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Directory $DOTFILES_DIR does not exist. Creating it..."
    mkdir -p "$DOTFILES_DIR"
fi

# Check if `stow` is installed
if ! command -v stow &>/dev/null; then
    echo "GNU Stow is not installed. Installing with pacman..."
    sudo pacman -S --noconfirm stow
else
    echo "GNU Stow is already installed."
fi

# Stow all subdirectories (packages) inside dotfiles
echo "Stowing all packages in $DOTFILES_DIR to $TARGET_DIR..."

# Loop through each subdirectory in dotfiles and stow it individually
for package in "$DOTFILES_DIR"/*/; do
    # Skip if it's not a directory
    if [ ! -d "$package" ]; then
        continue
    fi
    
    # Get the directory name (package name)
    package_name=$(basename "$package")
    
    # Stow the package to the target directory
    echo "Stowing package: $package_name"
    stow -v --dir="$DOTFILES_DIR" --target="$TARGET_DIR" "$package_name"
done

echo "All packages stowed successfully."

