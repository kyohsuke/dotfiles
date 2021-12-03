# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

if [[ -s $HOME/.zsh/evalcache/evalcache.plugin.zsh ]] {
  source $HOME/.zsh/evalcache/evalcache.plugin.zsh
}


# {{{ Evaluates
  # {{{ Additional Path
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    # {{{ anyenv
      if [[ -s $HOME/.anyenv/bin/anyenv ]] {
        export PATH="$HOME/.anyenv/bin:$PATH"
        local PYENV_ROOT_PATH="$HOME/.anyenv/envs/pyenv"
        if [[ -s $PYENV_ROOT_PATH ]] {
          export PATH="$PYENV_ROOT_PATH/shims:$PATH"
        }
        _evalcache anyenv init --no-rehash - zsh
      }
      export PATH="$HOME/bin:$HOME/sbin:$PATH"
    # }}} 
    # {{{ direnv
      if type direnv &>/dev/null; then
        _evalcache direnv hook zsh
      fi
    # }}}
    # {{{ docker-machine
      if type docker-machine &>/dev/null; then
        _evalcache docker-machine env default
      fi
    # }}}
  # }}}
# }}} 
