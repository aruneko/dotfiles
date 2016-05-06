#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$home/.dotfiles

  has() {
    type "$1" > /dev/null 2>&1
  }

  symlink() {
    [ -e "$2" ] || ln -s "$1" "$2"
  }

  install_package() {
    if [ -e /etc/arch-release ]; then
      yaourt -S "$1"
    fi
  }

  if [-d "$dotfiles" ]; then
    (cd "$dotfiles" && git pull --rebase)
  else
    git clone https://github.com/aruneko/dotfiles "$dotfiles"
  fi

  if ! test has zsh; then
    intall_package "zsh zsh-completions zsh-syntax-highlighting"
  fi 
  symlink "$dotfiles/.zshrc" "$HOME/.zshrc"

  if ! test has vim; then
    install_package "vim"
  fi
  symlink "$dotfiles/.vimrc" "$HOME/.vimrc"

  if ! test has xmonad; then
    install_package "xmonad xmonad-contrib xmobar dmenu2"
  fi
  symlink "$dotfiles/.xmonad" "$HOME/.xmonad"
}
