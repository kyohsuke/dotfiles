source "$HOME/.fishenv"

if status --is-login && test -f "$HOME/.fish_profile"
  source "$HOME/.fish_profile"
end

if status --is-login || status --is-interactive
  if test -f "$HOME/.fishrc"
    source "$HOME/.fishrc"
  end
end

if status --is-login && test -f "$HOME/.fish_login"
  source "$HOME/.fish_login"
end
