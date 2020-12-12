# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git sublime osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Alias
alias static-serve="python -m http.server"
alias ngrok="~/.ngrok"
alias codegit="GIT_EDITOR=\"code --wait\" git"
alias git=hub
alias kube=kubectl
alias tf=terraform
alias gcloud-prod="gcloud --project=alg-analytics"
alias gcloud-test="gcloud --project=alg-analytics-test"
alias cbt-usage="cbt -project=alg-analytics -instance=alg-log-processing-production"

# Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Ruby
export PATH="$HOME/.rvm/bin:$PATH"

# Python
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Go
export GOPATH="$HOME/Work/go"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# Vault
export PATH="$HOME/Work/vault/bin:$PATH"
export VAULT_ADDR="https://vault-elb.algolia.net:8200"

# psql
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PSQL_EDITOR="code -w"

# LDAP username
export AUSER=svaillant

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/samuelvaillant/Work/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/samuelvaillant/Work/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/samuelvaillant/Work/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/samuelvaillant/Work/google-cloud-sdk/completion.zsh.inc'; fi

# The next line enables shell command completion for kubectl.
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Kube context
if [ -f '/usr/local/opt/kube-ps1/share/kube-ps1.sh' ]; then
  source '/usr/local/opt/kube-ps1/share/kube-ps1.sh'
  KUBE_PS1_NS_ENABLE=false
  PROMPT='$(kube_ps1) '$PROMPT
fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
