# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# {{{ Evaluates
  # {{{ Additional Path
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    # {{{ anyenv
      if [[ -s $HOME/.anyenv/bin/anyenv ]] {
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init --no-rehash - zsh)"
      }
      export PATH="$HOME/bin:$HOME/sbin:$PATH"
    # }}} 
    # {{{ direnv
      if [[ -s /usr/local/bin/direnv ]] {
        eval "$(direnv hook zsh)"
      }
    # }}}
  # }}}
# }}} 
