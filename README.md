# device-setup

This repo houses all the instructions to setup a laptop to my personal spec.

## Terminal Configuration

### ZSH Configuration

Paste this into `~/.zshrc`

```zsh
# ZSH setup
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
export ZSH=$HOME/.oh-my-zsh

# Plugins
plugins=(git aws kube-ps1 kubectl terraform asdf zsh-completions)

# Initialize completions
autoload -Uz compinit
compinit -u

# Aliases for common commands
alias kc='kubecolor'
alias kx='kubectx'
alias kn='kubens'
alias ll='ls -lG'
alias aws-azure-auth-stg="parallel 'aws-azure-login -p {} -m cli' ::: g-gov-high-stg-app c-gov-high-stg-app g-gov-high-stg-mgmt c-gov-high-stg-mgmt"
alias aws-azure-auth-prod="parallel 'aws-azure-login -p {} -m cli' ::: g-gov-high-prod-app c-gov-high-prod-app g-gov-high-prod-mgmt c-gov-high-prod-mgmt"

# Theme and plugins
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Key bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Powerlevel10k configuration
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time dir kubecontext)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status battery)
POWERLEVEL9K_STATUS_VERBOSE=true
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_DIR_DEFAULT_FOERGROUND="white"
POWERLEVEL9K_BATTERY_VERBOSE=false
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_TIME_FOREGROUND="white"
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
POWERLEVEL9K_KUBECONTEXT_BACKGROUND="darkgoldenrod"

# Path configurations
export GOPATH=$HOME/go
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ASDF setup
. $(brew --prefix)/opt/asdf/libexec/asdf.sh

# Environment variables (sensitive values redacted)
export ARTIFACTORY_USERNAME="<REDACTED>"
export ARTIFACTORY_PASSWORD="<REDACTED>"
export GITHUB_TOKEN="<REDACTED>"
export HOMEBREW_NO_AUTO_UPDATE=1
export NODE_EXTRA_CA_CERTS="$HOME/ca-cert/ZscalerRootCertificate-2048-SHA256.crt"

# History settings
HISTSIZE=10000000
SAVEHIST=10000000

# Cosign configuration (keys redacted)
export COSIGN_KEY='<REDACTED>'
export COSIGN_PASSWORD='<REDACTED>'
```

## Homebrew Installations

I use a Brewfile to manage all my Homebrew packages. This makes it easy to install everything with a single command.

### Using the Brewfile

```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install all packages from Brewfile
brew bundle
```

## VS Code Configuration

VS Code settings and extensions are stored in the `vscode` directory.

### Setup VS Code

```bash
# Run the setup script to install settings and extensions
cd vscode
./setup.sh
```

This will:

1. Copy your settings to the VS Code user directory
2. Install all extensions listed in `extensions.txt`

### Manual Export (for future updates)

To export your current VS Code settings:

```bash
# Export settings
cp ~/Library/Application\ Support/Code/User/settings.json /path/to/repo/vscode/

# Export extensions list
code --list-extensions > /path/to/repo/vscode/extensions.txt
```
