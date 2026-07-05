if test -f "$HOME/.config/fish/env"
    source "$HOME/.config/fish/env"
end

if status --is-login; and test -f "$HOME/.config/fish/profile"
    source "$HOME/.config/fish/profile"
end

if begin; status --is-login; or status --is-interactive; end; and test -f "$HOME/.config/fish/rc"
    source "$HOME/.config/fish/rc"
end

if status --is-login; and not test -f "$HOME/.config/fish/profile"; and test -f "$HOME/.config/fish/login"
    source "$HOME/.config/fish/login"
end

# {{{ Change Key Bindings if its not vim terminal
if set -q VIM_TERMINAL
    fish_default_key_bindings
end
# }}}
