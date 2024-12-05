# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' frequency 13
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# Preferred editor for local and remote sessions
export EDITOR='vim'
export TERMINAL=alacritty
export PATH=$PATH:/home/itmam/.dotnet
export PATH=$PATH:/usr/local/bin
# Set personal aliases, overriding those provided by Oh My Zsh libs,
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)

eval "$(starship init zsh)"

# utils
# alias la="ls -la"
alias usb="lsblk"
alias drive-mount="rclone mount google-drive: ~/drive --exclude '/robotics/**' &"
alias drive-sync="rclone sync google-drive:/ /home/itmam/drive/ --exclude '/robotics/**'"
alias drive-sync-local="rclone sync /home/itmam/drive google-drive:/ --exclude '/robotics/**'"

# git aliases
alias add="git add"
alias commit="git commit -m"

