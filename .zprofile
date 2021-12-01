# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

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
        eval "$(anyenv init --no-rehash - zsh)"
      }
      export PATH="$HOME/bin:$HOME/sbin:$PATH"
    # }}} 
    # {{{ direnv
      if type direnv &>/dev/null; then
        eval "$(direnv hook zsh)"
      fi
    # }}}
    # {{{ docker-machine
      if type docker-machine &>/dev/null; then
        eval "$(docker-machine env default)"
      fi
    # }}}
  # }}}
# }}} 
