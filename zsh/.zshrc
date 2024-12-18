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
export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh
#ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit)


############################################################
#                       ENVIRONMENT                        #
############################################################
export EDITOR="nvim"
export TERMINAL="alacritty"
export PATH="$PATH:/home/itmam/.dotnet"
export PATH="$PATH:/home/itmam/.dotnet/tools"
export PATH="$PATH:/usr/local/bin"


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

# env
alias path="echo -e ${PATH//:/\\n}"

# fancy commands
alias diskusage="free -m -l -t"
alias inet="ip -c -br -f inet a | grep UP"
alias startdocker="systemctl start docker"

eval "$(starship init zsh)"
