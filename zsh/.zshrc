############################################################
#   ___  __  __ _____      ____ ___  _   _ _____ ___ ____  #
#  / _ \|  \/  |__  /     / ___/ _ \| \ | |  ___|_ _/ ___| #
# | | | | |\/| | / /_____| |  | | | |  \| | |_   | | |  _  #
# | |_| | |  | |/ /|_____| |__| |_| | |\  |  _|  | | |_| | #
#  \___/|_|  |_/____|     \____\___/|_| \_|_|   |___\____| #
#                                                          #
############################################################


############################################################
#                    omz config stuff                      #
############################################################
export ZSH_DISABLE_COMPFIX=true
export ZSH="/home/itmam/.oh-my-zsh"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
#ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)


############################################################
#                       ENVIRONMENT                        #
############################################################
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="/home/itmam/.dotnet:$PATH"
export PATH="/home/itmam/.dotnet/tools:$PATH"
export PATH="$PATH:/usr/local/bin"
export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORMTHEME=kde
export DOTNET_ROOT="/home/itmam/.dotnet"

unset QT_STYLE_OVERRIDE

############################################################
#                         ALIASES                          #
############################################################

# google drive
alias drive-mount="rclone mount google-drive: ~/drive --exclude '/robotics/**' &"
alias drive-sync="rclone sync google-drive:/ /home/itmam/drive/ --exclude '/robotics/**'"
alias drive-sync-local="rclone sync /home/itmam/drive google-drive:/ --exclude '/robotics/**'"

# git aliases
alias g="git"
alias commit="g commit -m"

# renames
alias p="sudo pacman"
alias v="nvim"
alias usb="lsblk"
alias top="btop"
alias google="google-chrome-stable"
alias grep="grep --color=auto"
alias mem="ncdu --color=dark"

# env
alias path="echo -e ${PATH}"

# fancy commands
alias diskusage="free -m -l -t"
alias inet="ip -c -br -f inet a | grep UP"
alias startdocker="systemctl start docker"

eval "$(starship init zsh)"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
