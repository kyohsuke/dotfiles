test -f "$HOME/.config/fish/env"
and source "$HOME/.config/fish/env"

status --is-login
and test -f "$HOME/.config/fish/profile"
and source "$HOME/.config/fish/profile"

if status --is-login || status --is-interactive
  test -f "$HOME/.config/fish/rc"
  and source "$HOME/.config/fish/rc"
end

status --is-login
and not test -f "$HOME/.config/fish/profile"
and test -f "$HOME/.config/fish/login"
and source "$HOME/.config/fish/login"
