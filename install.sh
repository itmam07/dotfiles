#!/bin/sh

# Dotfiles directory (adjust if your repo lives elsewhere)
DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: directory $DOTFILES_DIR does not exist."
    exit 1
fi

# Require GNU Stow to be installed; do not attempt package manager installs here.
if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU Stow is not installed. Please install 'stow' and re-run this script."
    exit 1
fi

cd "$DOTFILES_DIR" || exit 1

stow_target_for() {
    case "$1" in
        config)     printf "%s" "$HOME/.config" ;; 
        themes)     printf "%s" "$HOME/.local/share/themes" ;; 
        wallpapers) printf "%s" "$HOME/.config/wallpapers" ;;
        zsh|vim)    printf "%s" "$HOME" ;;
        *)          printf "%s" "$HOME" ;;
    esac
}

echo "Stowing dotfiles from $DOTFILES_DIR"

for entry in */; do
    [ -d "$entry" ] || continue
    name=${entry%/}
    # skip hidden or special directories
    case "$name" in
        .*) continue ;;
    esac

    target=$(stow_target_for "$name")
    echo "Stowing: $name -> $target"
    stow -v -t "$target" "$name"
done

echo "All done."

