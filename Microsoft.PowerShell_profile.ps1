# starship config

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\starship.toml"

# Chocolatey stuff

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#   Import-Module "$ChocolateyProfile"
# }

# aliases
function Git-Status() {
    git status
}

function Git-Add-All() {
    git add .
}

function Git-Add($file) {
    git add $file
    Write-Output "git: staged $file"
}

function Git-Restore($file) {
    git restore --staged $file
    Write-Output "git: restored previously staged file $file"
}

function Git-Commit($message) {
    git commit -m $message
}

function Git-Push() {
    git push -u origin main
}

Set-Alias -Name gs -Value Git-Status

# Set-Alias -Name add -Value Git-Add-All
Set-Alias -Name add -Value Git-Add
Set-Alias -Name restore -Value Git-Restore

Set-Alias -Name commit -Value Git-Commit
Set-Alias -Name push -Value Git-Push