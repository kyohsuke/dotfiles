test -f "$HOME/.fishenv"
and source "$HOME/.fishenv"

test -f "$HOME/.fish_profile"
and status --is-login
and source "$HOME/.fish_profile"

if status --is-login || status --is-interactive
  test -f "$HOME/.fishrc"
  and source "$HOME/.fishrc"
end

if status --is-login && test -f "$HOME/.fish_login" && not test -f "$HOME/.fish_profile"
  and source "$HOME/.fish_login"
end
