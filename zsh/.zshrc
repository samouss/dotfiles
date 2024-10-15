# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="norm"

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

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Git
alias codegit="GIT_EDITOR=\"code --wait\" git"

# Fastlane
# export PATH="$HOME/.fastlane/bin:$PATH"

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use

# # Yarn
# export PATH="$HOME/.yarn/bin:$PATH"

# Ruby
# export PATH="$HOME/.rvm/bin:$PATH"

# Python
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"

# Go
export GOPATH="$HOME/Work/go"
export PATH="$GOPATH/bin:$PATH"
export GO111MODULE=on

# Vault
export VAULT_ADDR="https://vault-elb.algolia.net:8200"

# psql
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"
export PSQL_EDITOR="code -w"

# The next line updates PATH for the Google Cloud SDK.
# if [ -f "$HOME/Work/google-cloud-sdk/path.zsh.inc" ]; then
#   . "$HOME/Work/google-cloud-sdk/path.zsh.inc";
# fi

# The next line enables shell command completion for gcloud.
# if [ -f "$HOME/Work/google-cloud-sdk/completion.zsh.inc" ]; then
#   . "$HOME/Work/google-cloud-sdk/completion.zsh.inc";
# fi

# The next line enables shell command completion for kubectl.
# if [ $commands[kubectl] ]; then
#   source <(kubectl completion zsh)
# fi

# K8s.
alias kube=kubectl
alias kubens="kubectl config set-context --current --namespace "
alias codekube="KUBE_EDITOR=\"code -w\" kubectl"
if [ -f "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh" ]; then
  source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
  KUBE_PS1_NS_ENABLE=true
  PROMPT='$(kube_ps1) '$PROMPT
fi

# Terraform
alias tf=terraform
# if [ -f '/usr/local/bin/terraform' ]; then
#   autoload -U +X bashcompinit && bashcompinit
#   complete -o nospace -C /usr/local/bin/terraform terraform
# fi

# LLVM
export CC="$(brew --prefix)/opt/llvm@16/bin/clang"
export CXX="$(brew --prefix)/opt/llvm@16/bin/clang++"
export LDFLAGS="${LDFLAGS} -L$(brew --prefix)/opt/llvm@16/lib -Wl,-rpath,$(brew --prefix)/opt/llvm@16/lib"
export PATH="$(brew --prefix)/opt/llvm@16/bin:$PATH"

# Functions
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
