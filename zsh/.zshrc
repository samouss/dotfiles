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
plugins=(git macos)

# https://github.com/ohmyzsh/ohmyzsh/issues/31
unsetopt nomatch

# Disable ZSH message about permissions.
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Fastlane
# export PATH="$HOME/.fastlane/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

# Alias
alias static-serve="python -m http.server"
alias ngrok="~/.ngrok"
alias codegit="GIT_EDITOR=\"code --wait\" git"
alias git=hub
alias kube=kubectl
alias codekube="KUBE_EDITOR=\"code -w\" kubectl"
alias kubens="kubectl config set-context --current --namespace "
alias tf=terraform

# Algolia
alias gcloud-prod="gcloud --project=alg-analytics"
alias gcloud-test="gcloud --project=alg-analytics-test"
alias gcloud-perso="gcloud --project=playground-248912"
alias cbt-usage="cbt -project=alg-analytics -instance=alg-log-processing-production"

function gcpactivate() {
  gcloud config configurations activate $1
  gcloud auth application-default login
}

function gcpkubeauth() {
  make -f build/analytics/Makefile auth-$1
}

function internalmetispgopen() {
  local port=5433
  local proxy="svc/psql-proxy"
  if [[ "$2" == "search" ]]; then
    port=5434
    proxy="svc/psql-search-proxy"
  fi

  metiskube $1
  kube port-forward ${proxy} $port:5432 &>/dev/null &
  while true; do
    pg_isready -h localhost -p $port &>/dev/null
    if [[ $? -eq 0 ]] then
      break
    fi
    sleep 1
  done
}

function internalmetispgclose() {
  local proxy="svc/psql-proxy"
  if [[ "$1" == "search" ]]; then
    proxy="svc/psql-search-proxy"
  fi

  kill $(pgrep -f $proxy)
}

function internalmetispgurl() {
  local pass=$(vault read -field=$2-admin-password secret/algolia/metis/instances/$1/database)
  local port=5433
  if [[ "$2" == "search" ]]; then
    port=5434
  fi

  echo "host=localhost port=$port dbname=metis user=algolia password=$pass sslmode=require"
}

function metispg() {
  internalmetispgopen $1 $2
  psql "$(internalmetispgurl $1 $2)"
  internalmetispgclose $2
}

# Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# Ruby
# export PATH="$HOME/.rvm/bin:$PATH"

# Python
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Work/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/Work/google-cloud-sdk/path.zsh.inc";
fi

# The next line enables shell command completion for gcloud.
# if [ -f "$HOME/Work/google-cloud-sdk/completion.zsh.inc" ]; then
#   . "$HOME/Work/google-cloud-sdk/completion.zsh.inc";
# fi

# The next line enables shell command completion for kubectl.
# if [ $commands[kubectl] ]; then
#   source <(kubectl completion zsh)
# fi

# Kubectl
export PATH="/usr/local/opt/kubernetes-cli@1.22/bin:$PATH"

# Kube context
if [ -f '/usr/local/opt/kube-ps1/share/kube-ps1.sh' ]; then
  source '/usr/local/opt/kube-ps1/share/kube-ps1.sh'
  KUBE_PS1_NS_ENABLE=true
  PROMPT='$(kube_ps1) '$PROMPT
fi

# The next line enables shell command completion for Terraform.
# if [ -f '/usr/local/bin/terraform' ]; then
#   autoload -U +X bashcompinit && bashcompinit
#   complete -o nospace -C /usr/local/bin/terraform terraform
# fi

# Algolia Engine
export CC=/usr/local/opt/llvm/bin/clang
export CXX=/usr/local/opt/llvm/bin/clang++
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export PATH="/usr/local/opt/llvm/bin:$PATH"
