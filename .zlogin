# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# {{{ User specific aliases and functions 
# {{{ Aliases
alias dcs='docker stats $(docker-compose ps -q || echo "#")'
alias gup='git pull --rebase && git dmb'
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
  # See Also: https://www.keisuke69.net/entry/2020/06/04/145719
  alias aws='docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'

  cloud_sdk_commands=('gcloud' 'gsutil' 'bq')
  for command in $cloud_sdk_commands
  do
    alias $command="docker run --rm -it --workdir='/gcloud' -v ~/.config/gcloud:/root/.config/gcloud -v \$(pwd):/gcloud google/cloud-sdk $command"
  done

  alias ffmpeg='docker run --rm -it --workdir="/config" -v $(pwd):/config linuxserver/ffmpeg'
fi

# }}}
# {{{ Functions
function twitch() {
  curl --silent -H "Client-ID: ${TWITCH_CLIENT_ID}" -H 'Accept: application/vnd.twitchtv.v3+json' -X GET https://api.twitch.tv/kraken/users/kyohsuke/follows/channels \
    | jq -r '.follows[].channel.name' \
    | xargs -I {} -n 1 -P 4 curl --silent -H "Client-ID: ${TWITCH_CLIENT_ID}" -H 'Accept: application/vnd.twitchtv.v3+json' -X GET https://api.twitch.tv/kraken/streams/\{\} \
    | jq -r 'select(.stream != null) | .stream.channel.name' \
    | peco --prompt="Twitch Live Channels> " | head -1 | xargs -I {} livestreamer --twitch-oauth-token ${TWITCH_OAUTH_TOKEN} twitch.tv/{} best 
}
function radio() {
  curl --silent -H "Client-ID: ${TWITCH_CLIENT_ID}" -H 'Accept: application/vnd.twitchtv.v3+json' -X GET https://api.twitch.tv/kraken/users/kyohsuke/follows/channels \
    | jq -r '.follows[].channel.name' \
    | xargs -I {} -n 1 -P 4 curl --silent -H "Client-ID: ${TWITCH_CLIENT_ID}"  -H 'Accept: application/vnd.twitchtv.v3+json' -X GET https://api.twitch.tv/kraken/streams/\{\} \
    | jq -r 'select(.stream != null) | .stream.channel.name' \
    | peco --prompt="Twitch Live Channels> " | head -1 | xargs -I {} livestreamer --twitch-oauth-token ${TWITCH_OAUTH_TOKEN} twitch.tv/{} audio
}
function qtwitch() {
    livestreamer --twitch-oauth-token ${TWITCH_OAUTH_TOKEN} twitch.tv/$1 best
}
function loc() {
  mdfind -onlyin $PWD -name $*
}

function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

function spellout() {
  rbenv exec rails new $* -m https://raw.github.com/RailsApps/rails-composer/master/composer.rb
}

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
  git checkout $(git branch | peco --query "$LBUFFER" | awk '{print $NF}')
  zle accept-line
}
zle -N git-checkout-other-branch
bindkey -v '^K' git-checkout-other-branch
# }}}
# }}}
