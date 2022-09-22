if test -s "$HOME/.anyenv/bin/anyenv"
  fish_add_path "$HOME/.anyenv/bin"
  _evalcache anyenv init --no-rehash - fish

  # goenv
  if test -f "$HOME/.anyenv/envs/goenv/bin/goenv"
    set -gx GOENV_DISABLE_GOPATH 1
    set -gx GOPATH "$HOME"
    set -gx GOBIN "$GOROOT/bin"
  end

  # pyenv
  if test -f "$HOME/.anyenv/envs/pyenv/bin/pyenv"
    set -gx PYTHONDONTWRITEBYTECODE 1
    set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
    set -gx PYTHON_CONFIGURE_OPTS "--enable-framework --enable-optimizations --with-lto"
  end

  # rbenv
  if test -f "$HOME/.anyenv/envs/rbenv/bin/rbenv"
    set -gx GEM_EDITOR "mvim"
    set -gx RUBY_YJIT_ENABLE 1
  end
end
