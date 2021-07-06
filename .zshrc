# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# {{{ Init oh-my-zsh
plugins=(bundler rails rake-fast redis-cli vagrant docker docker-compose)
plugin_paths=('/usr/local/share/zsh-completions')
for ppath in $plugin_paths
do
  [[ -d $ppath ]] && fpath=($fpath $ppath)
done
fpath=($fpath $HOME/.zsh-completions)
source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit -C -i -d "${ZSH_COMPDUMP}"
# }}}
# {{{ Sources
# {{{ Zaw
source $HOME/.zsh/zaw/zaw.zsh
bindkey -v '^h' zaw-history
# }}}
source $HOME/.zsh/bd/bd.zsh
source $HOME/.zsh/zsh-system-clipboard/zsh-system-clipboard.zsh
# }}}
# {{{ auto build ssh/config file.
function check_ssh_config {
  case $OSTYPE in
  darwin*)
    local CMD_CAT=$(whereis cat)
    local CMD_HEAD=$(whereis head)
    local CMD_SED=$(whereis sed)
    ;;
  linux*)
    local CMD_CAT="/bin/cat"
    local CMD_HEAD="/usr/bin/head"
    local CMD_SED="/bin/sed"
    ;;
  esac

  local CMECKSUM_HEADER_PREFIX="# md5sum:"

  if [[ ! -d $HOME/.ssh ]] {
    echo "[INFO] .ssh directory does not found. create."
    mkdir $HOME/.ssh
    chmod 700 $HOME/.ssh
  }

  local CURRENT_CONFIG="$HOME/.ssh/config"
  local CURRENT_CONFIG_MD5
  if [[ -f $CURRENT_CONFIG ]] {
    CURRENT_CONFIG_MD5=$($CMD_HEAD -1 $CURRENT_CONFIG | $CMD_SED "s/${CMECKSUM_HEADER_PREFIX} //g" )
  }

  local BEFORE_CONFIG="$HOME/.ssh_config.d/before_config"
  local LOCAL_CONFIG="$HOME/.ssh_config.local"
  local AFTER_CONFIG="$HOME/.ssh_config.d/after_config"


  if [[ ! -d $HOME/.ssh_config.d ]] {
    echo "[INFO] migrate directory does not found. create its directory."
    mkdir $HOME/.ssh_config.d
    if [[ -f $CURRENT_CONFIG ]] {
      echo "[INFO] .ssh/config already exists. copy currnet config to .ssh_config.local"
      if [[ -f $LOCAL_CONFIG ]] {
        echo ".ssh_config.local already exists... append mode."
        echo "$($CMD_CAT $CURRENT_CONFIG)" >> $LOCAL_CONFIG
      } else {
        echo "$($CMD_CAT $CURRENT_CONFIG)" > $LOCAL_CONFIG
      }
    }
  }

  if [[ ! -f $BEFORE_CONFIG ]] {
    echo "[INFO] before_config does not found. create it."
    echo "# write your settings without Host/Match" > $BEFORE_CONFIG
  }

  if [[ ! -f $AFTER_CONFIG ]] {
    echo "[INFO] after_config does not found. create it."
    echo "# write your settings with Host/Match" > $AFTER_CONFIG
  }


  local NEXT_CONFIG_FILES
  if [[ -f $LOCAL_CONFIG ]] {
    NEXT_CONFIG_FILES=($BEFORE_CONFIG $LOCAL_CONFIG $AFTER_CONFIG)
  } else {
    NEXT_CONFIG_FILES=($BEFORE_CONFIG $AFTER_CONFIG)
  }

  local NEXT_CONFIG="$($CMD_CAT ${NEXT_CONFIG_FILES[@]})"

  local NEXT_CONFIG_MD5
  case $OSTYPE in
  darwin*)
    NEXT_CONFIG_MD5="$($CMD_CAT ${NEXT_CONFIG_FILES[@]} | md5)"
    ;;
  linux*)
    NEXT_CONFIG_MD5="$($CMD_CAT ${NEXT_CONFIG_FILES[@]} | md5sum | awk '{print $1}')"
    ;;
  esac
  alias sshconfig="$EDITOR -o $NEXT_CONFIG_FILES && check_ssh_config"

  if [[ $CURRENT_CONFIG_MD5 != $NEXT_CONFIG_MD5 ]] {
    echo "ssh_config has been changed. rebuilding. ( $CURRENT_CONFIG_MD5 vs $NEXT_CONFIG_MD5 )"
    echo -n "" > $CURRENT_CONFIG
    echo "$CMECKSUM_HEADER_PREFIX $NEXT_CONFIG_MD5" >> $CURRENT_CONFIG
    echo "# generate: $(date +'%Y-%m-%d %H:%M:%S') " >> $CURRENT_CONFIG
    for CONFIG_SOURCE in $NEXT_CONFIG_FILES
    do
      echo "" >> $CURRENT_CONFIG
      echo "# -- build from: ${CONFIG_SOURCE##*/}" >> $CURRENT_CONFIG
      echo "$($CMD_CAT $CONFIG_SOURCE)" >> $CURRENT_CONFIG
    done
    chmod 644 $CURRENT_CONFIG
  }
}
check_ssh_config
# }}}
# {{{ History
HISTSIZE=1000
SAVEHIST=1000
# }}}
# {{{ option,limit,bindkey
zmodload zsh/zpty

setopt hist_ignore_all_dups
setopt hist_reduce_blanks

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors $LSCOLORS
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
# }}}
# {{{ Draw ENV 
setopt prompt_subst
# zsh option setting
setopt auto_cd
# }}}
# {{{ Addrev
typeset -A myabbrev
myabbrev=(
  "pecommit"  "git commit -m '_|_' \$(git status --porcelain | sed s/^...// | peco | tr '\\n' ' ')"
)

my-expand-abbrev() {
    if [ -z "$RBUFFER" ] ; then
        my-expand-abbrev-aux
    else
        zle end-of-line
    fi
}

my-expand-abbrev-aux() {
    local init last value addleft addright
    init=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    last=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    value=${myabbrev[$last]}
    if [[ $value = *_\|_* ]] ; then
        addleft=${value%%_\|_*}
        addright=${value#*_\|_}
    else
        addleft=$value
        addright=""
    fi
    if [ "$last" = "PWD" ] ; then
        LBUFFER=""
        RBUFFER="$PWD"
    else
        LBUFFER=$init${addleft:-$last }
        RBUFFER=$addright$RBUFFER
    fi
}

zle -N my-expand-abbrev
bindkey "^e" my-expand-abbrev
# }}}
# {{{ PROMPT Theme
if [[ $ZSH_THEME -eq "robbyrussel" ]] {
  export PROMPT=$'%{$fg[yellow]%}[ %~ ] %{$reset_color%}${${KEYMAP/vicmd/[N]}/(main|viins)/$fg_bold[yellow]-I-${reset_color}}\n ${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'
}
function zle-line-init zle-keymap-select {
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
# }}}
# {{{ Cache Rebuild
function zrebuild() {
  rm -f ~/.zcompdump;
  zmodload -i zsh/complist
  zcompile ~/.zshrc
  autoload -Uz compinit
  compinit -C -i -d "${ZSH_COMPDUMP}"
}
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  echo ".zshrc has been changed. recompiling."
  zrebuild
fi
# }}}
# {{{ load localfile
if [ -r "$HOME/.zshrc.local" ]; then
  source $HOME/.zshrc.local
fi
# }}}
