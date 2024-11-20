#!/bin/bash

# Define the dotfiles directory and the target directory
DOTFILES_DIR="$HOME/dotfiles"
TARGET_DIR="$HOME"

# Ensure the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Directory $DOTFILES_DIR does not exist. Exiting..."
    exit 1
fi

# Check if `stow` is installed
if ! command -v stow &>/dev/null; then
    echo "GNU Stow is not installed. Please install it first."
    exit 1
else
    echo "GNU Stow is installed."
fi

# Unstow all subdirectories (packages) inside dotfiles
echo "Unstowing all packages from $DOTFILES_DIR..."

# Loop through each subdirectory in dotfiles and unstow it individually
for package in "$DOTFILES_DIR"/*/; do
    # Skip if it's not a directory
    if [ ! -d "$package" ]; then
        continue
    fi
    
    # Get the directory name (package name)
    package_name=$(basename "$package")
    
    # Unstow the package from the target directory
    echo "Unstowing package: $package_name"
    stow -D -v --dir="$DOTFILES_DIR" --target="$TARGET_DIR" "$package_name"
done

echo "All packages unstowed successfully."

