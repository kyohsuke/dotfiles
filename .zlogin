# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# {{{ User specific aliases and functions 
# {{{ Aliases
alias dcs='docker stats $(docker-compose ps -q || echo "#")'
alias gup='git pull --rebase'
alias rm='rm -i'
alias ll='ls -l'
alias df='df -h'
alias bc='bc -l'
alias gd="source $HOME/sbin/cd-git-root"
alias scrr='screen -U -D -RR'
alias diff='diff -W ${COLUMNS}'
alias ber='bundle exec ruby'
alias time='/usr/bin/time'
alias locate='mdfind -name'
alias top='top -o cpu'
alias svc='brew services'
vim_version=`vim --version | head -1 | sed 's/^.*\ \([0-9]\)\.\([0-9]\)\ .*$/\1\2/'`
alias less="/usr/share/vim/vim${vim_version}/macros/less.sh"
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias toweb='ruby -run -e httpd . -p5000'
alias vcat='vimcat'
alias cat='bat --paging=never'
alias ls='ls -G'
alias cp='cp -v -i'
alias mv='mv -v -i'
alias git=hub
alias zshconfig="$EDITOR ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias vimrc="$EDITOR ~/.vimrc"
alias f='thefuck'

if [ -r "/usr/local/bin/docker" ]; then
  cloud_sdk_commands=('gcloud' 'gsutil' 'bq')
  for command in $cloud_sdk_commands
  do
    alias $command="docker run --rm -it --workdir='/gcloud' -v ~/.config/gcloud:/root/.config/gcloud -v \$(pwd):/gcloud google/cloud-sdk $command"
  done
fi

# }}}
# {{{ Functions
function loc() {
  mdfind -onlyin $PWD -name $*
}

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco --query "$LBUFFER"`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey -v '^h' peco-history-selection

function ghq-cd() {
  local DEST=$(ghq list --full-path | peco --query "$LBUFFER")
  if [[ -n $DEST ]] {
    cd $DEST
    zle accept-line
  }
}
zle -N ghq-cd
bindkey -v '^O' ghq-cd

function git-checkout-other-branch() {
  git checkout "$(git branch | peco --query "$LBUFFER" | awk '{print $NF}')"
  zle accept-line
}
zle -N git-checkout-other-branch
bindkey -v '^K' git-checkout-other-branch
# }}}
# }}}
