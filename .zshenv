# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# zmodload zsh/zprof && zprof

# {{{ Pragma Once
if [[ -z $ZSHENV_LOAD ]] {
  # {{{ Exports
  export ZSH_DISABLE_COMPFIX='true'
  export ZSHENV_LOAD="1"
  export DISABLE_AUTO_UPDATE="true"
  export TZ=Asia/Tokyo
  export LANG=ja_JP.UTF-8
  export LESSCHARSET=UTF-8
  export OUTPUT_CHARSET=UTF-8
  export ARCHFLAGS="-arch x86_64"

  export ZSH=$HOME/.oh-my-zsh
  export ZSH_CUSTOM=$HOME/.zsh-custom
  export ZSH_THEME="robbyrussell"
  export GEM_EDITOR="mvim"
  export MONO_GAC_PREFIX="/usr/local"
  export ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump"

  export UNBUNDLED_COMMANDS=(
    rake
    cap
    irb
  )

  if [ -r "/usr/local/bin/files" ]; then
    export FILES_IGNORE_PATTERN='(^(\.git|\.hg|\.svn|_darcs|\.bzr|tmp|\.vagrant|\.keep|\.log|.tmp|\.DS_Store)$|node_modules)'
  fi

  export HOMEBREW_INSTALL_CLEANUP="1"
  export EDITOR="mvim -f --cmd 'autocmd VimLeave * :!open -a Terminal'"
  [[ -r "/usr/local/bin/gpg" ]] && export GPG_TTY=$(tty)

  export GOPATH=$HOME
  export MANPATH="/usr/local/share/man:$MANPATH"

  # Google Cloud SDK
  export CLOUDSDK_PYTHON="/usr/local/opt/python@3.8/libexec/bin/python"
  if [ -r "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
  fi
  if [ -r "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
    source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  fi

  if [ -r "/usr/local/bin/bat" ]; then
    export MANPAGER="sh -c 'col -bx | bat -pl man'"
    export BAT_PAGER="less -FR"
  fi

  # for python and pyenv
  export PYTHONDONTWRITEBYTECODE=1
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1

  # pyenv
  export PYTHON_CONFIGURE_OPTS="--enable-framework"

  # bat
  export BAT_STYLE="plain"

  # libffi
  [[ -r "/usr/local/opt/libffi/lib/pkgconfig" ]] && export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"

  # CA Bundle
  if [ -r "/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt" ]; then
    export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt
  fi
  export PSQL_EDITOR='gvim +"set syntax=sql" '
  # }}}
  # {{{ load localfile
  if [ -r "$HOME/.zshenv.local" ]; then
    source $HOME/.zshenv.local
  fi
  # }}}
}
# }}}
