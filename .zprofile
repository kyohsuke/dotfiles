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
        export GOBIN="$GOROOT/bin"
      }
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
    # {{{
      if type brew  &>/dev/null; then
        _evalcache brew shellenv
      fi
    # }}}
    # {{{ rancher desktop
      if [[ -s $HOME/.rd/bin ]] {
        export PATH="$HOME/.rd/bin:$PATH"
      }
    # }}}
    export PATH="$HOME/bin:$HOME/sbin:$PATH"
  # }}}
# }}} 
if [ ! -f ~/.zprofile.zwc -o ~/.zprofile -nt ~/.zprofile.zwc ]; then
  echo ".zprofile has been changed. recompiling."
  zcompile "$HOME/.zprofile"
fi
