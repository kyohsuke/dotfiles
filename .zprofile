# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=zsh

# {{{ Evaluates
# {{{ Additional Path
additional_paths=('/usr/local/heroku/bin' '/usr/local/mysql/bin')
for apath in $additional_paths
do
  [[ -d $apth ]] && export PATH="$apath:$PATH"
done
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
# {{{ anyenv
if [[ -s $HOME/.anyenv/bin/anyenv ]] {
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init --no-rehash - zsh)"
}
export PATH="$HOME/bin:$HOME/sbin:$PATH"
# }}} 
# {{{ direnv
eval "$(direnv hook zsh)"
# }}}
# }}}
# }}} 
