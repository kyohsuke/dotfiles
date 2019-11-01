#!/usr/bin/env bash

ANYENVS=(
  rbenv
  pyenv
  nodenv
)

NODENV_PLUGINS=(
  pine/nodenv-yarn-install
  ouchxp/nodenv-nvmrc
)

PYENV_PLUGINS=(
  yyuu/pyenv-pip-migrate
  jawshooah/pyenv-default-packages
)

RBENV_PLUGINS=(
  mlafeldt/rbenv-man
  tpope/rbenv-readline
  rbenv/rbenv-default-gems
  rbenv/rbenv-each
)

install_nodenv_plugins() {
  for PLUGIN in "${NODENV_PLUGINS[@]}";
  do
    echo "[CHECK] ${PLUGIN}"
    if [ ! -d "$(ndenv root)/plugins/${PLUGIN##*/}" ]; then
      git clone "https://github.com/${PLUGIN}" "$(ndenv root)/plugins/${PLUGIN##*/}"
    fi
  done
}

install_pyenv_plugins() {
  for PLUGIN in "${PYENV_PLUGINS[@]}";
  do
    echo "[CHECK] ${PLUGIN}"
    if [ ! -d "$(pyenv root)/plugins/${PLUGIN##*/}" ]; then
      git clone "https://github.com/${PLUGIN}" "$(pyenv root)/plugins/${PLUGIN##*/}"
    fi
  done
cat <<EOS > "$(rbenv root)/default-packages"
thefuck
EOS
}

install_rbenv_plugins() {
for PLUGIN in "${RBENV_PLUGINS[@]}";
do
  echo "[CHECK] ${PLUGIN}"
  if [ ! -d "$(rbenv root)/plugins/${PLUGIN##*/}" ]; then
    git clone "https://github.com/${PLUGIN}" "$(rbenv root)/plugins/${PLUGIN##*/}"
  fi
done
cat <<EOS > "$(rbenv root)/default-gems"
bundler
bundler-audit
solargraph
EOS
}



# install Anyenv
if ! [ -e "$HOME/.anyenv" ]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  PATH="$HOME/.anyenv/bin:$PATH"
  mkdir -p "$(anyenv root)/plugins"
  git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"

  eval "$("$HOME/.anyenv/bin/anyenv" init -)"
fi

# Install envs
for ANYENV in "${ANYENVS[@]}"
do
  if ! [ -e "$HOME/.anyenv/envs/$ANYENV" ]; then
    anyenv install "$ANYENV"
    mkdir -p "$($ANYENV root)/plugins"
  fi
done

# install Anyenv
if ! [ -e "$HOME/.anyenv" ]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  PATH="$HOME/.anyenv/bin:$PATH"
  eval "$("$HOME/.anyenv/bin/anyenv" init -)"
  for ANYENV in "${ANYENVS[@]}"
  do
    anyenv install "$ANYENV"
  done
  mkdir -p "$(anyenv root)/plugins"
  git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"

  eval "$("$HOME/.anyenv/bin/anyenv" init -)"

  mkdir -p "$(pyenv root)/plugins"
  mkdir -p "$(rbenv root)/plugins"
  mkdir -p "$(ndenv root)/plugins"

  install_nodenv_plugins
  install_pyenv_plugins
  install_rbenv_plugins

  # install ruby
  if [ -f .ruby-version ]; then
    rbenv install
    rbenv rehash
  fi

  # install node
  if [ -f .node-version ]; then
    nodenv install
    nodenv rehash
  fi

  # install python
  if [ -f .python-version ]; then
    VERSIONS=$(cat .python-version)
    for VERSION in $VERSIONS
    do
      pyenv install "$VERSION"
    done
    pyenv rehash
  fi
fi

install_nodenv_plugins
install_pyenv_plugins
install_rbenv_plugins
