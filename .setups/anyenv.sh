#!/usr/bin/env bash

ANYENVS=(
  rbenv
  pyenv
  nodenv
  goenv
)

NODENV_PLUGINS=(
  pine/nodenv-yarn-install
  ouchxp/nodenv-nvmrc
  nodenv/nodenv-default-packages
  nodenv/nodenv-npm-migrate
)

PYENV_PLUGINS=(
  yyuu/pyenv-pip-migrate
  jawshooah/pyenv-default-packages
)

RBENV_PLUGINS=(
  rbenv/rbenv-default-gems
)

install_nodenv_plugins() {
  for PLUGIN in "${NODENV_PLUGINS[@]}"; do
    echo "[CHECK] ${PLUGIN}"
    if [ ! -d "$(nodenv root)/plugins/${PLUGIN##*/}" ]; then
      git clone "https://github.com/${PLUGIN}" "$(nodenv root)/plugins/${PLUGIN##*/}"
    fi
  done
  ln -s "$HOME/.default-node-packages" "$(nodenv root)/default-packages"
}

install_pyenv_plugins() {
  for PLUGIN in "${PYENV_PLUGINS[@]}"; do
    echo "[CHECK] ${PLUGIN}"
    if [ ! -d "$(pyenv root)/plugins/${PLUGIN##*/}" ]; then
      git clone "https://github.com/${PLUGIN}" "$(pyenv root)/plugins/${PLUGIN##*/}"
    fi
  done
  ln -s "$HOME/.default-packages" "$(pyenv root)/default-packages"
}

install_rbenv_plugins() {
  for PLUGIN in "${RBENV_PLUGINS[@]}"; do
    echo "[CHECK] ${PLUGIN}"
    if [ ! -d "$(rbenv root)/plugins/${PLUGIN##*/}" ]; then
      git clone "https://github.com/${PLUGIN}" "$(rbenv root)/plugins/${PLUGIN##*/}"
    fi
  done
  ln -s "$HOME/.default-gems" "$(rbenv root)/default-gems"
}

# install Anyenv
if ! [ -e "$HOME/.anyenv" ]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
  PATH="$HOME/.anyenv/bin:$PATH"
  mkdir -p "$(anyenv root)/plugins"
  git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
  git clone https://github.com/znz/anyenv-git.git "$(anyenv root)/plugins/anyenv-git"
  "$HOME/.anyenv/bin/anyenv" install --force-init

  # Install envs
  for ANYENV in "${ANYENVS[@]}"; do
    anyenv install "$ANYENV"
  done
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
    for VERSION in $VERSIONS; do
      pyenv install "$VERSION"
    done
    pyenv rehash
  fi
fi
