test -f "$HOME/.fishenv"
and source "$HOME/.fishenv"

status --is-login
and test -f "$HOME/.fish_profile"
and source "$HOME/.fish_profile"

if status --is-login || status --is-interactive
  test -f "$HOME/.fishrc"
  and source "$HOME/.fishrc"
end

status --is-login
and not test -f "$HOME/.fish_profile"
and test -f "$HOME/.fish_login"
and source "$HOME/.fish_login"
